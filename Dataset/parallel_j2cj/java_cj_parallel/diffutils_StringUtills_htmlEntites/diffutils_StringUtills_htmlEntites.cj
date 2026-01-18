    public static func htmlEntites(str: String): String {
        return str.replace("<", "&lt;").replace(">", "&gt;")
    }