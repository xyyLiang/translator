    public static func create(): Grammar {
        return GrammarImpl(
            "brainfuck",
            ArrayList<Token>(
                Prism.token("pointer", Prism.pattern(Regex("<|>"), false, false, "keyword")),
                Prism.token("increment", Prism.pattern(Regex("\\+"), false, false, "inserted")),
                Prism.token("decrement", Prism.pattern(Regex("-"), false, false, "deleted")),
                Prism.token("branching", Prism.pattern(Regex("\\[|\\]"), false, false, "important")),
                Prism.token("operator", Prism.pattern(Regex("[.,]"))),
                Prism.token("comment", Prism.pattern(Regex("\\S+")))
            )
        )
    }