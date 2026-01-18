    public func append(b: CharArrayBuffer) {
        if(!b.isEmpty()) {
            this.append(b.buffer, 0, b.len)
        }
    }