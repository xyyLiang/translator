    static func readFully(ins: StringReader<InputStream>): String {
        var str: String = ins.readToEnd()
        return str
    }