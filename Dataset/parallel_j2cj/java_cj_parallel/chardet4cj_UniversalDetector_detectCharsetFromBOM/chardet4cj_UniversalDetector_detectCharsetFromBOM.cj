    public static func detectCharsetFromBOM(buf: Array<Byte>): String {
     return detectCharsetFromBOM(buf, 0)
    }