    public func substringTrimmed(begin: Int32, end: Int32): String {
        var beginIndex: Int32 = begin
        var endIndex: Int32 = end
        if(beginIndex < 0) {
            throw IndexOutOfBoundsException()
        } else if(endIndex > this.len) {
            throw IndexOutOfBoundsException()
        } else if(beginIndex > endIndex) {
            throw IndexOutOfBoundsException()
        } else {
            while(beginIndex < endIndex && HTTP.isWhitespace(this.buffer[Int64(beginIndex)])) {
                beginIndex++
            }
            while(endIndex > beginIndex && HTTP.isWhitespace(this.buffer[Int64(endIndex - 1)])) {
                endIndex--
            }
            return this.buffer.toString().substring(Int64(beginIndex), Int64(endIndex - beginIndex))
        }
    }