 public int getClass(byte b) {
        int c = b & 0xFF;
        return this.classTable.unpack(c);
    }