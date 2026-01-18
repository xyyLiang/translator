    public void append(String str) {
        if(str == null) {
            str = "null";
        }

        int strlen = str.length();
        int newlen = this.len + strlen;
        if(newlen > this.buffer.length) {
            this.expand(newlen);
        }

        str.getChars(0, strlen, this.buffer, this.len);
        this.len = newlen;
    }