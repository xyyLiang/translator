    public func parseNameValuePair(buffer: CharArrayBuffer, cursor: ParserCursor, delimiters: Array<Char>): BasicNameValuePair {
        var terted: Bool = false
        var pos: Int32 = cursor.getPos()
        let indexFrom = cursor.getPos()
        var indexTo: Int32 = cursor.getUpperBound()
        for (i in pos..(indexTo-1)) {
            pos++
            let value = buffer.charAt(pos)
            if(value == Char(Int32(61))) {
                break
            }
            if(isOneOf(value, delimiters)) {
                terted = true
                break
            }
        }
        var name: String
        if(pos == indexTo) {
            terted = true
            name = buffer.substringTrimmed(indexFrom, indexTo)
        } else {
            name = buffer.substringTrimmed(indexFrom, pos)
            pos++
        }
        if(terted) {
            cursor.updatePos(pos)
            return this.createNameValuePair(name, "")
        } else {
            var i1: Int32 = pos
            var qout: Bool = false
            for (i in pos..indexTo) {
                let is2 = buffer.charAt(pos)
                var esced: Bool = false
                if(is2 == Char(34) && !esced) {
                    qout = !qout
                }
                if(!qout && !esced && isOneOf(is2, delimiters)) {
                    terted = true
                    break
                }
                if(esced) {
                    esced = false
                } else {
                    esced = (qout && is2 == Char(92))
                }
            }
            var var15: Int32 = pos
            if (i1 < var15) {
                for (i in i1..var15) {
                    if (HTTP.isWhitespace(buffer.charAt(i1))) {
                        i1++
                    }
                    if (HTTP.isWhitespace(buffer.charAt(var15 - 1))) {
                        var15--
                    }
                }
            }
            if(var15 - i1 >= 2 && buffer.charAt(i1) == Char(34) && buffer.charAt(var15 - 1) == Char(34)) {
                i1++
                var15--
            }
            let var14 = buffer.substring(i1, var15)
            if(terted) {
                pos++
            }
            cursor.updatePos(pos)
            return this.createNameValuePair(name, var14)
        }
    }