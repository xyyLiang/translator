    private int writeEntryHeaderField(final long value, final byte[] outbuf, final int offset, final int length, final boolean starMode) {
        if (!starMode && (value < 0 || value >= 1L << 3 * (length - 1))) {
            // value doesn't fit into field when written as octal
            // number, will be written to PAX header or causes an
            // error
            return TarUtils.formatLongOctalBytes(0, outbuf, offset, length);
        }
        return TarUtils.formatLongOctalOrBinaryBytes(value, outbuf, offset, length);
    }