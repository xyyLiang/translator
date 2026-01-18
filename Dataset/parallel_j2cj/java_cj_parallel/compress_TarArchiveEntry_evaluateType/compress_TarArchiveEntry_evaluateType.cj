    private func evaluateType(header: Array<Byte>): Int64 {
        if (ArchiveUtils.matchAsciiBuffer(TarConstants.MAGIC_GNU, header, offset: TarConstants.MAGIC_OFFSET, length: TarConstants.MAGICLEN)) {
            return TarConstants.FORMAT_OLDGNU
        }
        if (ArchiveUtils.matchAsciiBuffer(TarConstants.MAGIC_POSIX, header, offset: TarConstants.MAGIC_OFFSET, length: TarConstants.MAGICLEN)) {
            if (ArchiveUtils.matchAsciiBuffer(TarConstants.MAGIC_XSTAR, header, offset: TarConstants.XSTAR_MAGIC_OFFSET, length: TarConstants.XSTAR_MAGIC_LEN)) {
                return TarConstants.FORMAT_XSTAR
            }
            return TarConstants.FORMAT_POSIX
        }
        return 0
    }