    public static func insertBeforeToken(grammar: Grammar, path: String, tokens: ArrayList<Token>): Unit {
        let parts: Array<String> = path.split("/")
        insertBeforeToken(grammar, parts, 0, tokens.toArray())
    }