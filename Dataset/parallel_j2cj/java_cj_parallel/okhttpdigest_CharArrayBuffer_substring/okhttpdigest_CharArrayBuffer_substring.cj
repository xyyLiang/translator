    public func substring(beginIndex: Int32, endIndex: Int32): String {
        if(beginIndex < 0) {
            throw IndexOutOfBoundsException()
        } else if(endIndex > this.len) {
            throw IndexOutOfBoundsException()
        } else if(beginIndex > endIndex) {
            throw IndexOutOfBoundsException()
        } else {
            return this.buffer.toString().substring(Int64(beginIndex), Int64(endIndex - beginIndex))
        }
    }