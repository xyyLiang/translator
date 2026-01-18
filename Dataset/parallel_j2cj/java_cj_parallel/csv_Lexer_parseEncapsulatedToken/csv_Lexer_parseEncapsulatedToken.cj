    private func parseEncapsulatedToken(token: Token): Unit {
        token.isQuoted = true
        let startLineNumber = getCurrentLineNumber();
        while (true) {
            var readChr = reader.read();

            // The end of the stream is reached before the next quotation mark is touched
            if (reader.getIsEndOfStream()) {
                throw Exception("(startline ${startLineNumber}) EOF reached before encapsulated token finished");
            }
            var tmpChr = readChr ?? Constants.DISABLED

            // Escape character or not
            if (isEscape(tmpChr)) {
                if (isEscapeDelimiter()) {
                    // Add the separator to the contents of the token
                    token.content.append(delimiter);
                } else {
                    // Read escaped characters
                    if (let Some(value) <- readEscape()) {
                        token.content.append(value)
                    } else {
                        token.content.append(tmpChr)
                    }
                }
            } else if (isQuoteChar(tmpChr)) { // If it is a reference symbol
                if (parseDoubleQuoteToken(token)) {
                    return
                }
            } else {
                token.content.append(tmpChr);
            }
        }
    }