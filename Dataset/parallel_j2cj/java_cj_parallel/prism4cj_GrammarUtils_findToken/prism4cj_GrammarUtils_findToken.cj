    public static func findToken(grammar: Grammar, path: String): ?Token {
        let parts: Array<String> = path.split("/")
        return findToken(grammar, parts, 0)
    }