    public func indexOf(ch: Char, begin: Int32, end: Int32): Int32 {
        var beginIndex: Int32 = begin
        var endIndex: Int32 = end
        if(beginIndex < 0) {
            beginIndex = 0
        }

        if(endIndex > this.len) {
            endIndex = this.len
        }

        if(beginIndex > endIndex) {
            return -1
        } else {

            for (i in beginIndex..(endIndex-1)) {
                 if(this.buffer[Int64(i)] == ch) {
                     return i
                 }
            }
            return -1
        }
    }