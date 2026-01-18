    public static func parseName(buffer: Array<Byte>, offset: Int64, length: Int64): String {
        try {
            return parseNameEncoding(buffer, offset, length, TarUtils.DEFAULT_ENCODING)
        } catch (ex: IOException | TarIOException) { // NOSONAR
            try {
                return parseNameEncoding(buffer, offset, length, TarUtils.FALLBACK_ENCODING)
            } catch (ex2: IOException | TarIOException) {
                // impossible
                throw Exception("impossible") //NOSONAR
            }
        }
    }