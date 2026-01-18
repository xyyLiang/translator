    private static func bytesToString(bytes: Array<Int8>, characterSet: String): String {
        var s: String = bytesToCharBuffer(bytes, characterSet)
        var length: Int64 = match (s.indexOf(Char(0).toString())) {
            case Some(x) => x
            case None => -1
        }
        if (length == -1) {
            return s
        }
        return s[..length]
    }