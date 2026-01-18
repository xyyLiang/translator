    public static func token(name: String, patterns: ArrayList<Pattern>): Token {
        return TokenImpl(name, patterns)
    }