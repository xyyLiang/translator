    static func toString(grammar: Grammar): String {
        let builder: StringBuilder = StringBuilder()
        toString(builder, CacheImpl(), grammar)
        return builder.toString()
    }