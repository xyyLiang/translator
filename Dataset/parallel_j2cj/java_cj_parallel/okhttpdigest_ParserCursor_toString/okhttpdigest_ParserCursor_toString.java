    public String toString() {
        StringBuilder buffer = new StringBuilder(16);
        buffer.append('[');
        buffer.append(this.lowerBound);
        buffer.append('>');
        buffer.append(this.pos);
        buffer.append('>');
        buffer.append(this.upperBound);
        buffer.append(']');
        return buffer.toString();
    }