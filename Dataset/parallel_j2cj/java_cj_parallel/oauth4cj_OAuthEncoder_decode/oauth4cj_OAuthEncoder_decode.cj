    public static func decode(encoded: String): String {
        if (encoded.isEmpty()) {
            return ""
        }
        try {
            return URLEncoder.decode(encoded, CHARSET)
        } catch (e: Exception) {
            throw OAuth4cjException("Charset not found while decoding string: " + CHARSET + e.message)
        }
    }