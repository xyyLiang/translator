    public static func create(): Grammar {
        return GrammarImpl(
            "json",
            ArrayList<Token>(
                Prism.token(
                    "property",
                    Prism.pattern(Regex("\"(?:\\\\.|[^\\\\\"\\r\\n])*\"(?=\\s*:)", RegexOption().ignoreCase()))
                ),
                Prism.token("string", Prism.pattern(Regex("\"(?:\\\\.|[^\\\\\"\\r\\n])*\"(?!\\s*:)"), false, true)),
                Prism.token(
                    "number",
                    Prism.pattern(Regex("\\b0x[\\dA-Fa-f]+\\b|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:[Ee][+-]?\\d+)?"))
                ),
                Prism.token("punctuation", Prism.pattern(Regex("[{}\\[\\]);,]"))),
                // not sure about this one...
                Prism.token("operator", Prism.pattern(Regex(":"))),
                Prism.token("boolean", Prism.pattern(Regex("\\b(?:true|false)\\b", RegexOption().ignoreCase()))),
                Prism.token("null", Prism.pattern(Regex("\\bnull\\b", RegexOption().ignoreCase())))
            )
        )
    }