    static func toString(pattern: Pattern): String {
        let builder: StringBuilder = StringBuilder()
        toString(builder, CacheImpl(), pattern)
        return builder.toString()
    }