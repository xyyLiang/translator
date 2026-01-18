    void update(final int inCh) {
        int temp = crc >> 24 ^ inCh;
        if (temp < 0) {
            temp = 256 + temp;
        }
        crc = crc << 8 ^ CRC.crc32Table[temp];
    }