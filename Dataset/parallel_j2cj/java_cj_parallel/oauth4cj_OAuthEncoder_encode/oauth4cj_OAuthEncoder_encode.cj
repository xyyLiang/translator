    public static func encode(src: String): String {
        if (src.isEmpty()) {
            return ""
        }
        var encoded: String = ""
        try {
            encoded = URLEncoder.encode(src, CHARSET)
        } catch (e: Exception) {
            throw OAuth4cjException("Charset not found while encoding string: " + CHARSET + e.message)
        }

        encoded = encoded.replace("*", "%2A")
        encoded = encoded.replace("+", "%20")
        encoded = encoded.replace("%7E", "~")
        return encoded
    }