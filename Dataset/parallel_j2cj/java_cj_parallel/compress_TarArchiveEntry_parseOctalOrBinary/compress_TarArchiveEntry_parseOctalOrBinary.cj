    private func parseOctalOrBinary(header: Array<Byte>, offset: Int64, length: Int64, lenient: Bool): Int64 {
        if (lenient) {
            try {
                return TarUtils.parseOctalOrBinary(header, offset, length)
            } catch (ex: Exception) {
                return TarArchiveEntry.UNKNOWN
            }
        }
        return TarUtils.parseOctalOrBinary(header, offset, length)
    }