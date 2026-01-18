    public func append(ch: Char) {
        let newlen: Int32 = this.len + 1
        if(newlen > Int32(this.buffer.capacity())) {
            this.expand(newlen)
        }
        this.buffer.insert(Int64(this.len), ch)
        this.len = newlen
    }