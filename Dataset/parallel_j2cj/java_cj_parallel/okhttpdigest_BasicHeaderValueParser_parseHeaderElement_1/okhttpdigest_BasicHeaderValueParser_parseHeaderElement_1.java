    public HeaderElement parseHeaderElement(CharArrayBuffer buffer, ParserCursor cursor) {
        Args.notNull(buffer, "Char array buffer");
        Args.notNull(cursor, "Parser cursor");
        NameValuePair nvp = this.parseNameValuePair(buffer, cursor);
        NameValuePair[] params = null;
        if(!cursor.atEnd()) {
            char ch = buffer.charAt(cursor.getPos() - 1);
            if(ch != 44) {
                params = this.parseParameters(buffer, cursor);
            }
        }

        return this.createHeaderElement(nvp.getName(), nvp.getValue(), params);
    }