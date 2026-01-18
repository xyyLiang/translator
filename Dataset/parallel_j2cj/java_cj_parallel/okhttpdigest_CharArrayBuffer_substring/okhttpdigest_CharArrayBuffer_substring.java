    public String substring(int beginIndex, int endIndex) {
        if(beginIndex < 0) {
            throw new IndexOutOfBoundsException();
        } else if(endIndex > this.len) {
            throw new IndexOutOfBoundsException();
        } else if(beginIndex > endIndex) {
            throw new IndexOutOfBoundsException();
        } else {
            return new String(this.buffer, beginIndex, endIndex - beginIndex);
        }
    }