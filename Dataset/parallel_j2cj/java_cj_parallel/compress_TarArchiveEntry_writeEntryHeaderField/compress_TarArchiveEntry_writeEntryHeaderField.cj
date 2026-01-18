    private func writeEntryHeaderField(value: Int64, outbuf: Array<Byte>, offset: Int64, length: Int64, starMode: Bool): Int64 {
        if (!starMode && (value < 0 || value >= 1 << 3 * (length - 1))) {
            return TarUtils.formatLongOctalBytes(0, outbuf, offset, length)
        }
        return TarUtils.formatLongOctalOrBinaryBytes(value, outbuf, offset, length)
    }