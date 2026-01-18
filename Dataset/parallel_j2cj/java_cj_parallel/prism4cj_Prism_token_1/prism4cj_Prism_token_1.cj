    public static func token(name: String, patterns: Array<Pattern>): Token {
        return TokenImpl(name, ArrayList(patterns))
    }