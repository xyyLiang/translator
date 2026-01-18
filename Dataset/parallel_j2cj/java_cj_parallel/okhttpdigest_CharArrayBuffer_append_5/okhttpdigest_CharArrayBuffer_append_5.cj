    public func append(b: Array<UInt8>, off: Int32, len: Int32) {
        if(!b.isEmpty()) {
            if(off >= 0 && off <= Int32(b.size) && len >= 0 && off + len >= 0 && off + len <= Int32(b.size)) {
                if(len != 0) {
                    let oldlen: Int32 = this.len
                    let newlen: Int32 = oldlen + len
                    if(newlen > Int32(this.buffer.capacity())) {
                        this.expand(newlen)
                    }


                    let bsize = off + len
                    for (i in off..bsize) {
                        this.buffer.append(Char(UInt32(b[Int64(i)])))
                    }
                    this.len = newlen
                }
            } else {
                throw IndexOutOfBoundsException()
            }
        }
    }