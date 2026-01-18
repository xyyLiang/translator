    public void ensureCapacity(int required) {
        if(required > 0) {
            int available = this.buffer.length - this.len;
            if(required > available) {
                this.expand(this.len + required);
            }

        }
    }