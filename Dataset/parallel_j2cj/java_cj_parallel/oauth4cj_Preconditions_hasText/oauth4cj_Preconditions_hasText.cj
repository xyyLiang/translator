    public static func hasText(str: String): Bool {
        if (str.isEmpty()) {
            return false
        }
        let array = str.toRuneArray()
        for (c in array) {
            if (!c.isWhiteSpace()) {
                return true
            }
        }
        return false
    }