  void sanitize() {
    // Return to consistent state.
    bracketDepth = cleaned = 0;
    sanitizedJson = null;

    State state = State.START_ARRAY;
    int n = jsonish.length();

    // Walk over each token and either validate it, by just advancing i and
    // computing the next state, or manipulate cleaned&sanitizedJson so that
    // sanitizedJson contains the sanitized equivalent of
    // jsonish.substring(0, cleaned).
    token_loop:
    for (int i = 0; i < n; ++i) {
      try {
        char ch = jsonish.charAt(i);
        if (SUPER_VERBOSE_AND_SLOW_LOGGING) {
          String sanitizedJsonStr =
            (sanitizedJson == null ? "" : sanitizedJson)
            + jsonish.substring(cleaned, i);
          System.err.println("i=" + i + ", ch=" + ch + ", state=" + state
                             + ", sanitized=" + sanitizedJsonStr);
        }
        switch (ch) {
          case '\t': case '\n': case '\r': case ' ':
            break;

          case '"': case '\'':
            state = requireValueState(i, state, true);
            int strEnd = endOfQuotedString(jsonish, i);
            sanitizeString(i, strEnd);
            i = strEnd - 1;
            break;

          case '(': case ')':
            // Often JSON-like content which is meant for use by eval is
            // wrapped in parentheses so that the JS parser treats contained
            // curly brackets as part of an object constructor instead of a
            // block statement.
            // We elide these grouping parentheses to ensure valid JSON.
            elide(i, i + 1);
            break;

          case '{': case '[':
            state = requireValueState(i, state, false);
            if (isMap == null) {
              isMap = new boolean[maximumNestingDepth];
            }
            boolean map = ch == '{';
            isMap[bracketDepth] = map;
            ++bracketDepth;
            state = map ? State.START_MAP : State.START_ARRAY;
            break;

          case '}': case ']':
            if (bracketDepth == 0) {
              elide(i, jsonish.length());
              break token_loop;
            }

            // Strip trailing comma to convert {"a":0,} -> {"a":0}
            // and [1,2,3,] -> [1,2,3,]
            switch (state) {
              case BEFORE_VALUE:
                insert(i, "null");
                break;
              case BEFORE_ELEMENT: case BEFORE_KEY:
                elideTrailingComma(i);
                break;
              case AFTER_KEY:
                insert(i, ":null");
                break;
              case START_MAP: case START_ARRAY:
              case AFTER_ELEMENT: case AFTER_VALUE: break;
            }

            --bracketDepth;
            char closeBracket = isMap[bracketDepth] ? '}' : ']';
            if (ch != closeBracket) {
              replace(i, i + 1, closeBracket);
            }
            state = bracketDepth == 0 || !isMap[bracketDepth - 1]
                ? State.AFTER_ELEMENT : State.AFTER_VALUE;
            break;
          case ',':
            if (bracketDepth == 0) { throw UNBRACKETED_COMMA; }
            // Convert comma elisions like [1,,3] to [1,null,3].
            // [1,,3] in JS is an array that has no element at index 1
            // according to the "in" operator so accessing index 1 will
            // yield the special value "undefined" which is equivalent to
            // JS's "null" value according to "==".
            switch (state) {
              // Normal
              case AFTER_ELEMENT:
                state = State.BEFORE_ELEMENT;
                break;
              case AFTER_VALUE:
                state = State.BEFORE_KEY;
                break;
              // Array elision.
              case START_ARRAY: case BEFORE_ELEMENT:
                insert(i, "null");
                state = State.BEFORE_ELEMENT;
                break;
              // Ignore
              case START_MAP: case BEFORE_KEY:
              case AFTER_KEY:
                elide(i, i + 1);
                break;
              // Supply missing value.
              case BEFORE_VALUE:
                insert(i, "null");
                state = State.BEFORE_KEY;
                break;
            }
            break;

          case ':':
            if (state == State.AFTER_KEY) {
              state = State.BEFORE_VALUE;
            } else {
              elide(i, i + 1);
            }
            break;

          case '/':
            // Skip over JS-style comments since people like inserting them into
            // data files and getting huffy with Crockford when he says no to
            // versioning JSON to allow ignorable tokens.
            int end = i + 1;
            if (i + 1 < n) {
              switch (jsonish.charAt(i + 1)) {
                case '/':
                  end = n;  // Worst case.
                  for (int j = i + 2; j < n; ++j) {
                    char cch = jsonish.charAt(j);
                    if (cch == '\n' || cch == '\r'
                        || cch == '\u2028' || cch == '\u2029') {
                      end = j + 1;
                      break;
                    }
                  }
                  break;
                case '*':
                  end = n;
                  if (i + 3 < n) {
                    for (int j = i + 2;
                         (j = jsonish.indexOf('/', j + 1)) >= 0;) {
                      if (jsonish.charAt(j - 1) == '*') {
                        end = j + 1;
                        break;
                      }
                    }
                  }
                  break;
              }
            }
            elide(i, end);
            i = end - 1;
            break;

          default:
            // Three kinds of other values can occur.
            // 1. Numbers
            // 2. Keyword values ("false", "null", "true")
            // 3. Unquoted JS property names as in the JS expression
            //      ({ foo: "bar"})
            //    which is equivalent to the JSON
            //      { "foo": "bar" }
            // 4. Cruft tokens like BOMs.

            // Look for a run of '.', [0-9], [a-zA-Z_$], [+-] which subsumes
            // all the above without including any JSON special characters
            // outside keyword and number.
            int runEnd;
            for (runEnd = i; runEnd < n; ++runEnd) {
              char tch = jsonish.charAt(runEnd);
              if (('a' <= tch && tch <= 'z') || ('0' <= tch && tch <= '9')
                  || tch == '+' || tch == '-' || tch == '.'
                  || ('A' <= tch && tch <= 'Z') || tch == '_' || tch == '$') {
                continue;
              }
              break;
            }

            if (runEnd == i) {
              elide(i, i + 1);
              break;
            }

            state = requireValueState(i, state, true);

            boolean isNumber = ('0' <= ch && ch <= '9')
               || ch == '.' || ch == '+' || ch == '-';
            boolean isKeyword = !isNumber && isKeyword(i, runEnd);

            if (!(isNumber || isKeyword)) {
              // We're going to have to quote the output.  Further expand to
              // include more of an unquoted token in a string.
              for (; runEnd < n; ++runEnd) {
                if (isJsonSpecialChar(runEnd)) {
                  break;
                }
              }
              if (runEnd < n && jsonish.charAt(runEnd) == '"') {
                ++runEnd;
              }
            }

            if (state == State.AFTER_KEY) {
              // We need to quote whatever we have since it is used as a
              // property name in a map and only quoted strings can be used that
              // way in JSON.
              insert(i, '"');
              if (isNumber) {
                // By JS rules,
                //   { .5e-1: "bar" }
                // is the same as
                //   { "0.05": "bar" }
                // because a number literal is converted to its string form
                // before being used as a property name.
                canonicalizeNumber(i, runEnd);
                // We intentionally ignore the return value of canonicalize.
                // Uncanonicalizable numbers just get put straight through as
                // string values.
                insert(runEnd, '"');
              } else {
                sanitizeString(i, runEnd);
              }
            } else {
              if (isNumber) {
                // Convert hex and octal constants to decimal and ensure that
                // integer and fraction portions are not empty.
                normalizeNumber(i, runEnd);
              } else if (!isKeyword) {
                // Treat as an unquoted string literal.
                insert(i, '"');
                sanitizeString(i, runEnd);
              }
            }
            i = runEnd - 1;
        }
      } catch (@SuppressWarnings("unused") UnbracketedComma e) {
        elide(i, jsonish.length());
        break;
      }
    }

    if (state == State.START_ARRAY && bracketDepth == 0) {
      // No tokens.  Only whitespace
      insert(n, "null");
      state = State.AFTER_ELEMENT;
    }

    if (SUPER_VERBOSE_AND_SLOW_LOGGING) {
      System.err.println(
          "state=" + state + ", sanitizedJson=" + sanitizedJson
          + ", cleaned=" + cleaned + ", bracketDepth=" + bracketDepth);
    }

    if ((sanitizedJson != null && sanitizedJson.length() != 0)
        || cleaned != 0 || bracketDepth != 0) {
      if (sanitizedJson == null) {
        sanitizedJson = new StringBuilder(n + bracketDepth);
      }
      sanitizedJson.append(jsonish, cleaned, n);
      cleaned = n;

      switch (state) {
        case BEFORE_ELEMENT: case BEFORE_KEY:
          elideTrailingComma(n);
          break;
        case AFTER_KEY:
          sanitizedJson.append(":null");
          break;
        case BEFORE_VALUE:
          sanitizedJson.append("null");
          break;
        default: break;
      }

      // Insert brackets to close unclosed content.
      while (bracketDepth != 0) {
        sanitizedJson.append(isMap[--bracketDepth] ? '}' : ']');
      }
    }
  }
