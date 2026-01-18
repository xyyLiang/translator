    public void setDataOffset(final long dataOffset) {
        if (dataOffset < 0) {
            throw new IllegalArgumentException("The offset can not be smaller than 0");
        }
        this.dataOffset = dataOffset;
    }