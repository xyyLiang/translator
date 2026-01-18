    public void append(byte[] b, int off, int len) {
        if(b != null) {
            if(off >= 0 && off <= b.length && len >= 0 && off + len >= 0 && off + len <= b.length) {
                if(len != 0) {
                    int oldlen = this.len;
                    int newlen = oldlen + len;
                    if(newlen > this.buffer.length) {
                        this.expand(newlen);
                    }

                    int i1 = off;

                    for(int i2 = oldlen; i2 < newlen; ++i2) {
                        this.buffer[i2] = (char)(b[i1] & 255);
                        ++i1;
                    }

                    this.len = newlen;
                }
            } else {
                throw new IndexOutOfBoundsException();
            }
        }
    }
