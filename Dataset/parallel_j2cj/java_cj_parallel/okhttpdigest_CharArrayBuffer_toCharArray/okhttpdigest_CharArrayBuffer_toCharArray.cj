    public func toCharArray(): Array<Char> {
        if(this.len > 0) {
            return Array<Char>(this.buffer.size, { i => this.buffer[i] })
        }
        return Array<Char>()
    }