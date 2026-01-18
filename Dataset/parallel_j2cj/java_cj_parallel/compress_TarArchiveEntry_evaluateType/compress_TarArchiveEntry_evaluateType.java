    private int evaluateType(final Map<String, String> globalPaxHeaders, final byte[] header) {
        if (ArchiveUtils.matchAsciiBuffer(MAGIC_GNU, header, MAGIC_OFFSET, MAGICLEN)) {
            return FORMAT_OLDGNU;
        }
        if (ArchiveUtils.matchAsciiBuffer(MAGIC_POSIX, header, MAGIC_OFFSET, MAGICLEN)) {
            if (isXstar(globalPaxHeaders, header)) {
                return FORMAT_XSTAR;
            }
            return FORMAT_POSIX;
        }
        return 0;
    }