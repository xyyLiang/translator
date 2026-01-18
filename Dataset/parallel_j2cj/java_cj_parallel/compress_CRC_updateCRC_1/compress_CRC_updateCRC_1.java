    void update(final int inCh, int repeat) {
        int globalCrcShadow = this.crc;
        while (repeat-- > 0) {
            final int temp = globalCrcShadow >> 24 ^ inCh;
            globalCrcShadow = globalCrcShadow << 8 ^ crc32Table[temp >= 0 ? temp : temp + 256];
        }
        this.crc = globalCrcShadow;
    }