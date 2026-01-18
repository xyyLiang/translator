    public void append(CharArrayBuffer b) {
        if(b != null) {
            this.append(b.buffer, 0, b.len);
        }
    }
