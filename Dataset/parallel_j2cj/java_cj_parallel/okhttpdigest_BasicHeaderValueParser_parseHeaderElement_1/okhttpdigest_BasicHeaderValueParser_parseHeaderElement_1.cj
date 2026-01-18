    public func parseHeaderElement(buffer: CharArrayBuffer, cursor: ParserCursor): BasicHeaderElement {

        var nvp: BasicNameValuePair = this.parseNameValuePair(buffer, cursor)
        var params: ArrayList<BasicNameValuePair> = ArrayList<BasicNameValuePair>()
        if(!cursor.atEnd()) {

            let ch = buffer.charAt(cursor.getPos() - 1)
            if(ch != Char(44)) {
                params = this.parseParameters(buffer, cursor)
            }
        }
        return this.createHeaderElement(nvp.getName(), nvp.getValue(), params)
    }