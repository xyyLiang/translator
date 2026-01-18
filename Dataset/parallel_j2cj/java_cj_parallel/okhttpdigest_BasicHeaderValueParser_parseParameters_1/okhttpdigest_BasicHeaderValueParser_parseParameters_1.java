    public NameValuePair[] parseParameters(CharArrayBuffer buffer, ParserCursor cursor) {
        Args.notNull(buffer, "Char array buffer");
        Args.notNull(cursor, "Parser cursor");
        int pos = cursor.getPos();

        for(int indexTo = cursor.getUpperBound(); pos < indexTo; ++pos) {
            char params = buffer.charAt(pos);
            if(!HTTP.isWhitespace(params)) {
                break;
            }
        }

        cursor.updatePos(pos);
        if(cursor.atEnd()) {
            return new NameValuePair[0];
        } else {
            ArrayList var8 = new ArrayList();

            while(!cursor.atEnd()) {
                NameValuePair param = this.parseNameValuePair(buffer, cursor);
                var8.add(param);
                char ch = buffer.charAt(cursor.getPos() - 1);
                if(ch == 44) {
                    break;
                }
            }

            return (NameValuePair[])var8.toArray(new NameValuePair[var8.size()]);
        }
    }
