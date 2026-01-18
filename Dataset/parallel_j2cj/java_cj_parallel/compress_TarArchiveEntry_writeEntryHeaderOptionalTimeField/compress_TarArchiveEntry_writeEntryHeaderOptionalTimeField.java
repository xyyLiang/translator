    private int writeEntryHeaderOptionalTimeField(final FileTime time, int offset, final byte[] outbuf, final int fieldLength) {
        if (time != null) {
            offset = writeEntryHeaderField(TimeUtils.toUnixTime(time), outbuf, offset, fieldLength, true);
        } else {
            offset = fill(0, offset, outbuf, fieldLength);
        }
        return offset;
    }