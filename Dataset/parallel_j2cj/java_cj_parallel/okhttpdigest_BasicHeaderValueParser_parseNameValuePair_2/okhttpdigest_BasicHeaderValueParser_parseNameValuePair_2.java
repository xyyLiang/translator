    public NameValuePair parseNameValuePair(CharArrayBuffer buffer, ParserCursor cursor, char[] delimiters) {
        Args.notNull(buffer, "Char array buffer");
        Args.notNull(cursor, "Parser cursor");
        boolean terminated = false;
        int pos = cursor.getPos();
        int indexFrom = cursor.getPos();

        int indexTo;
        for(indexTo = cursor.getUpperBound(); pos < indexTo; ++pos) {
            char value = buffer.charAt(pos);
            if(value == 61) {
                break;
            }

            if(isOneOf(value, delimiters)) {
                terminated = true;
                break;
            }
        }

        String name;
        if(pos == indexTo) {
            terminated = true;
            name = buffer.substringTrimmed(indexFrom, indexTo);
        } else {
            name = buffer.substringTrimmed(indexFrom, pos);
            ++pos;
        }

        if(terminated) {
            cursor.updatePos(pos);
            return this.createNameValuePair(name, null);
        } else {
            int i1 = pos;
            boolean qouted = false;

            for(boolean escaped = false; pos < indexTo; ++pos) {
                char i2 = buffer.charAt(pos);
                if(i2 == 34 && !escaped) {
                    qouted = !qouted;
                }

                if(!qouted && !escaped && isOneOf(i2, delimiters)) {
                    terminated = true;
                    break;
                }

                if(escaped) {
                    escaped = false;
                } else {
                    escaped = qouted && i2 == 92;
                }
            }

            int var15;
            for(var15 = pos; i1 < var15 && HTTP.isWhitespace(buffer.charAt(i1)); ++i1) {
            }

            while(var15 > i1 && HTTP.isWhitespace(buffer.charAt(var15 - 1))) {
                --var15;
            }

            if(var15 - i1 >= 2 && buffer.charAt(i1) == 34 && buffer.charAt(var15 - 1) == 34) {
                ++i1;
                --var15;
            }

            String var14 = buffer.substring(i1, var15);
            if(terminated) {
                ++pos;
            }

            cursor.updatePos(pos);
            return this.createNameValuePair(name, var14);
        }
    }
