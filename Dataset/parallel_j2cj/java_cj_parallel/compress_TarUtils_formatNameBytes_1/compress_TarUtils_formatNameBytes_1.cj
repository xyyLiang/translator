    @OverflowWrapping
    public static func formatNameBytes(name: String, buf: Array<Byte>, offset: Int64,
                                          length: Int64,
                                          encoding: ZipEncoding): Int64 {
        let nameChars = name.toRuneArray()
        var len: Int64 = nameChars.size
        var b = encoding.encode(name)
        while (b.limit() > length && len > 0) {
            len--
            b = encoding.encode(String(nameChars.slice(0, len)))
        }
        let limit: Int64 = b.limit() - b.position()
        ArrayCopy(b.array(), b.arrayOffset(), buf, offset, limit)

        // Pad any remaining output bytes with NUL
        for (i in limit.. length) {
            buf[offset + i] = 0
        }
        return offset + length
    }