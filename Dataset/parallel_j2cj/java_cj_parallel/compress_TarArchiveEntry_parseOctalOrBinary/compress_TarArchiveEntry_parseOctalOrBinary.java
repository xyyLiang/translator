    private long parseOctalOrBinary(final byte[] header, final int offset, final int length, final boolean lenient) {
        if (lenient) {
            try {
                return TarUtils.parseOctalOrBinary(header, offset, length);
            } catch (final IllegalArgumentException ex) { // NOSONAR
                return UNKNOWN;
            }
        }
        return TarUtils.parseOctalOrBinary(header, offset, length);
    }