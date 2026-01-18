    public int indexOf(int ch, int beginIndex, int endIndex) {
        if(beginIndex < 0) {
            beginIndex = 0;
        }

        if(endIndex > this.len) {
            endIndex = this.len;
        }

        if(beginIndex > endIndex) {
            return -1;
        } else {
            for(int i = beginIndex; i < endIndex; ++i) {
                if(this.buffer[i] == ch) {
                    return i;
                }
            }

            return -1;
        }
    }
