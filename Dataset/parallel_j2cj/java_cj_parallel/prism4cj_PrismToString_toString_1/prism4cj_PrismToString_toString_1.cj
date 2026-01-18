    static func toString(token: Token): String {
        let builder: StringBuilder = StringBuilder()
        toString(builder, CacheImpl(), token)
        return builder.toString()
    }