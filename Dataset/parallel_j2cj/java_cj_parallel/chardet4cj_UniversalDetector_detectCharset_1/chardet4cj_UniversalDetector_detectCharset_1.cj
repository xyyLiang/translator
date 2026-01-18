    public static func detectCharset(file: File): String {
        var outbuf: InputStream = (file as InputStream).getOrThrow()
        return detectCharset(outbuf)
    }