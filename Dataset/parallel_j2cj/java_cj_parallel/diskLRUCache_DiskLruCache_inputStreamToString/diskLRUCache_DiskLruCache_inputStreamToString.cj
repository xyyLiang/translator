    protected static func inputStreamToString(ins: InputStream): String {
        return Util.readFully(StringReader(ins))
    }
