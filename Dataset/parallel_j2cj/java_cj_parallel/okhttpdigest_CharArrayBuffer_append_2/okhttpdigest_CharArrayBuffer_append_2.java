    public void append(CharArrayBuffer b, int off, int len) {
        if(b != null) {
            this.append(b.buffer, off, len);
        }
    }
