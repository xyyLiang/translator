    public String substringTrimmed(int beginIndex, int endIndex) {
        if(beginIndex < 0) {
            throw new IndexOutOfBoundsException();
        } else if(endIndex > this.len) {
            throw new IndexOutOfBoundsException();
        } else if(beginIndex > endIndex) {
            throw new IndexOutOfBoundsException();
        } else {
            while(beginIndex < endIndex && HTTP.isWhitespace(this.buffer[beginIndex])) {
                ++beginIndex;
            }

            while(endIndex > beginIndex && HTTP.isWhitespace(this.buffer[endIndex - 1])) {
                --endIndex;
            }

            return new String(this.buffer, beginIndex, endIndex - beginIndex);
        }
    }
