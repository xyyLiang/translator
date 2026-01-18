    public func parseNameValuePair(buffer: CharArrayBuffer, cursor: ParserCursor): BasicNameValuePair {
        return this.parseNameValuePair(buffer, cursor, ALL_DELIMITERS)
    }