    public void append(char ch) {
        int newlen = this.len + 1;
        if(newlen > this.buffer.length) {
            this.expand(newlen);
        }

        this.buffer[this.len] = ch;
        this.len = newlen;
    }
