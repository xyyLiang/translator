  @SuppressWarnings("synthetic-access")
  private static CharSequence minify(CharSequence json) {
    Map<Token, Token> pool = new HashMap<Token, Token>();
    int n = json.length();
    for (int i = 0; i < n; ++i) {
      char ch = json.charAt(i);
      int tokEnd;
      if (ch == '"') {
        for (tokEnd = i + 1; tokEnd < n; ++tokEnd) {
          char tch = json.charAt(tokEnd);
          if (tch == '\\') {
            ++tokEnd;
          } else if (tch == '"') {
            ++tokEnd;
            break;
          }
        }
      } else if (isLetterOrNumberChar(ch)) {
        tokEnd = i + 1;
        while (tokEnd < n && isLetterOrNumberChar(json.charAt(tokEnd))) {
          ++tokEnd;
        }
      } else {
        continue;
      }

      int nextNonWhitespace = tokEnd;
      for (; nextNonWhitespace < n; ++nextNonWhitespace) {
        char wch = json.charAt(nextNonWhitespace);
        if (!(wch == '\t' || wch == '\n' || wch == '\r' || wch == ' ')) {
          break;
        }
      }

      // If the string is followed by a ':' then it is a map key and cannot be
      // substituted with an identifier.
      // In JavaScript, { a: 1 } is the same as { "a": 1 } regardless of
      // what the identifier "a" resolves to.
      if (nextNonWhitespace == n || ':' != json.charAt(nextNonWhitespace)
          && tokEnd - i >= 4) {
        Token tok = new Token(i, tokEnd, json);
        @Nullable Token last = pool.put(tok, tok);
        if (last != null) {
          tok.prev = last;
        }
      }

      i = nextNonWhitespace - 1;
    }

    // Now look at all the token groups that have a next, and then count up the
    // savings to see if they meet the cost of the boilerplate.
    int potentialSavings = 0;
    List<Token> dupes = new ArrayList<Token>();
    for (Iterator<Token> values = pool.values().iterator(); values.hasNext();) {
      Token tok = values.next();
      if (tok.prev == null) {
        values.remove();
        continue;
      }
      int chainDepth = 0;
      for (Token t = tok; t != null; t = t.prev) {
        ++chainDepth;
      }
      int tokSavings = (chainDepth - 1) * (tok.end - tok.start)
          - MARGINAL_VAR_COST;
      if (tokSavings > 0) {
        potentialSavings += tokSavings;
        for (Token t = tok; t != null; t = t.prev) {
          dupes.add(t);
        }
      }
    }
    if (potentialSavings <= BOILERPLATE_COST + SAVINGS_THRESHOLD) {
      return json;
    }

    // Dump the tokens into an array and sort them.
    Collections.sort(dupes);

    int nTokens = dupes.size();

    StringBuilder sb = new StringBuilder(n);
    sb.append(ENVELOPE_P1);

    {
      NameGenerator nameGenerator = new NameGenerator();
      boolean first = true;
      for (Token tok : pool.values()) {
        String name = nameGenerator.next();
        for (Token t = tok; t != null; t = t.prev) { t.name = name; }
        if (first) { first = false; } else { sb.append(','); }
        sb.append(name);
      }
    }

    sb.append(ENVELOPE_P2);
    int afterReturn = sb.length();
    int pos = 0, tokIndex = 0;
    while (true) {
      Token tok = tokIndex < nTokens ? dupes.get(tokIndex++) : null;
      int limit = tok != null ? tok.start : n;
      boolean inString = false;
      for (int i = pos; i < limit; ++i) {
        char ch = json.charAt(i);
        if (inString) {
          if (ch == '"') {
            inString = false;
          } else if (ch == '\\') {
            ++i;
          }
        } else if (ch == '\t' || ch == '\n' || ch == '\r' || ch == ' ') {
          if (pos != i) {
            sb.append(json, pos, i);
          }
          pos = i + 1;
        } else if (ch == '"') {
          inString = true;
        }
      }
      // There should be no token boundaries inside strings.
      assert !inString;
      if (pos != limit) {
        sb.append(json, pos, limit);
      }
      if (tok == null) { break; }
      sb.append(tok.name);
      pos = tok.end;
    }
    {
      // Insert space after return if required.
      // This is unlikely to occur in practice.
      char ch = sb.charAt(afterReturn);
      if (ch != '{' && ch != '[' && ch != '"') {
        sb.insert(afterReturn, ' ');
      }
    }
    sb.append(ENVELOPE_P3);
    {
      boolean first = true;
      for (Token tok : pool.values()) {
        if (first) { first = false; } else { sb.append(','); }
        sb.append(tok.seq, tok.start, tok.end);
      }
    }
    sb.append(ENVELOPE_P4);

    return sb;
  }
