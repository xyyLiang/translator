    public static func formatNameBytes(name: String, buf: Array<Byte>, offset: Int64, length: Int64): Int64 {
        try {
            return formatNameBytes(name, buf, offset, length, TarUtils.DEFAULT_ENCODING)
        } catch (ex: IOException | TarIOException) { // NOSONAR
            try {
                return formatNameBytes(name, buf, offset, length,
                    TarUtils.FALLBACK_ENCODING)
            } catch (ex2: IOException | TarIOException) {
                // impossible
                throw Exception(ex2.message) //NOSONAR
            }
        }
    }