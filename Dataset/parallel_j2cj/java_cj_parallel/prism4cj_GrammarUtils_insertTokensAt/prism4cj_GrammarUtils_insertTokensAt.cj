    private static func insertTokensAt(start: Int64, grammarTokens: ArrayList<Token>, tokens: Array<Token>) {
        for (i in 0..tokens.size) {
            grammarTokens.insert(start + i, tokens[i])
        }
    }