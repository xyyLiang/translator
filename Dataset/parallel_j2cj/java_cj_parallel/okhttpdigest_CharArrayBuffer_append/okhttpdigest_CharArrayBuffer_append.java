    public void append(char[] b, int off, int len) {
        if(b != null) {
            if(off >= 0 && off <= b.length && len >= 0 && off + len >= 0 && off + len <= b.length) {
                if(len != 0) {
                    int newlen = this.len + len;
                    if(newlen > this.buffer.length) {
                        this.expand(newlen);
                    }

                    System.arraycopy(b, off, this.buffer, this.len, len);
                    this.len = newlen;
                }
            } else {
                throw new IndexOutOfBoundsException();
            }
        }
    }