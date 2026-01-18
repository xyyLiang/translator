    public func ensureCapacity(required: Int32) {
        if(required > 0) {
            let available = Int32(this.buffer.capacity()) - this.len
            if(required > available) {
                this.expand(this.len + required)
            }

        }
    }