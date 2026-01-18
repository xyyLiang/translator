    private func parseSimpleToken(token: Token, ch: Rune): Unit {
        var tmpChr: Rune = ch
        while (true) {
            // If the flow ends, jump out
            if (reader.getIsEndOfStream()) {
                token.tokenType = TokenType.EOF
                token.isReady = true
                break
            }

            // Read a line and jump out
            if (readEndOfLine(tmpChr)) {
                token.tokenType = TokenType.EORECORD
                break
            }

            // Separator, jump out
            if (isDelimiter(tmpChr)) {
                token.tokenType = TokenType.TOKEN
                break
            }

            // Escape character or not
            if (isEscape(tmpChr)) {
                if (isEscapeDelimiter()) {
                    token.content.append(delimiter);
                } else {
                    let unescaped = readEscape();
                    match (unescaped) {
                        case None => token.content.append(ch)
                        case Some(value) => token.content.append(value);
                    }
                }
                tmpChr = reader.read() ?? Constants.DISABLED
            } else {
                token.content.append(tmpChr);
                tmpChr = reader.read() ?? Constants.DISABLED
            }
        }

        if (ignoreSurroundingSpaces) {
            trimTrailingSpaces(token.content);
        }
    }