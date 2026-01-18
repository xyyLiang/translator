    public NameValuePair parseNameValuePair(CharArrayBuffer buffer, ParserCursor cursor) {
        return this.parseNameValuePair(buffer, cursor, ALL_DELIMITERS);
    }