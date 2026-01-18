    public void updatePos(int pos) {
        if(pos < this.lowerBound) {
            throw new IndexOutOfBoundsException();
        } else if(pos > this.upperBound) {
            throw new IndexOutOfBoundsException();
        } else {
            this.pos = pos;
        }
    }