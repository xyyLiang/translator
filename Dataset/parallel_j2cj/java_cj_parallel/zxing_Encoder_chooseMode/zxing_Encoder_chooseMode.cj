    public static func chooseMode(content: String): Mode {
        var hasNumeric = false
        var hasAlphanumeric = false
        for (i in 0..content.size) {
            let c = content.charAt(i)
            if (c >= '0' && c <= '9') {
                hasNumeric = true
            } else if (getAlphanumericCode(Int64(UInt32(c))) != -1) {
                hasAlphanumeric = true
            } else {
                return Mode.BYTE
            }
        }
        if (hasAlphanumeric) {
            return Mode.ALPHANUMERIC
        }
        if (hasNumeric) {
            return Mode.NUMERIC
        }
        return Mode.BYTE
    }