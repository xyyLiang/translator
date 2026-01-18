    public func parseParameters(buffer: CharArrayBuffer, cursor: ParserCursor): ArrayList<BasicNameValuePair> {
        var pos = cursor.getPos()
        let indexTo = cursor.getUpperBound()
        for (i in pos..indexTo) {
            pos++
            let params = buffer.charAt(pos)
            if(!HTTP.isWhitespace(params)) {
                break
            }
        }

        cursor.updatePos(pos)
        if(cursor.atEnd()) {
            return ArrayList<BasicNameValuePair>()
        } else {
            var var8 = ArrayList<BasicNameValuePair>()

            while(true) {
                let param = this.parseNameValuePair(buffer, cursor)
                var8.append(param)
                let ch = buffer.charAt(cursor.getPos() - 1)
                if(ch == Char(44)) {
                    break
                }
                if(cursor.atEnd()) {
                    break
                }
            }
            return var8
        }
    }