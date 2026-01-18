    private Token parseSimpleToken(final Token token, int ch) throws IOException {
        // Faster to use while(true)+break than while(token.type == INVALID)
        while (true) {
            if (readEndOfLine(ch)) {
                token.type = EORECORD;
                break;
            }
            if (isEndOfFile(ch)) {
                token.type = EOF;
                token.isReady = true; // There is data at EOF
                break;
            }
            if (isDelimiter(ch)) {
                token.type = TOKEN;
                break;
            }
            // continue
            if (isEscape(ch)) {
                if (isEscapeDelimiter()) {
                    token.content.append(delimiter);
                } else {
                    final int unescaped = readEscape();
                    if (unescaped == END_OF_STREAM) { // unexpected char after escape
                        token.content.append((char) ch).append((char) reader.getLastChar());
                    } else {
                        token.content.append((char) unescaped);
                    }
                }
            } else {
                token.content.append((char) ch);
            }
            ch = reader.read(); // continue
        }

        if (ignoreSurroundingSpaces) {
            trimTrailingSpaces(token.content);
        }

        return token;
    }
