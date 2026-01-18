    private func expand(newlen: Int32) {
        let maxlen = max(Int32(this.buffer.capacity() << 1), newlen)
        let newbuffer = ArrayList<Char>(Int64(maxlen))
        for (i in 0..buffer.size) {
            newbuffer.insert(i,this.buffer[i])
        }
        this.buffer = newbuffer
    }