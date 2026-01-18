    public func append(b: ArrayList<Char>, off: Int32, len: Int32) {
        if(!b.isEmpty()) {
            if(off >= 0 && off <= Int32(b.size) && len >= 0 && off + len >= 0 && off + len <= Int32(b.size)) {
                if(len != 0) {
                    var newlen: Int32 = this.len + len
                    if(newlen > Int32(this.buffer.capacity())) {
                        this.expand(newlen)
                    }

                    let bsize = off + len
                    for (i in off..bsize) {
                        this.buffer.append(b[Int64(i)])
                    }
                    this.len = newlen
                }
            } else {
                throw IndexOutOfBoundsException()
            }
        }
    }