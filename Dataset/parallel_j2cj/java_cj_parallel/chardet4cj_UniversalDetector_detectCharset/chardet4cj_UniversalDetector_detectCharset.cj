    public static func detectCharset(path: Path): String {
        return detectCharset(File(path,OpenOption.Open(true,false)))
    }