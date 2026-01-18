    public static func create(prism: Prism): Grammar {
        let go: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "go",
            TokenFilterGoImpl(),
            ArrayList<Token>(
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                        "\\b(?:break|case|chan|const|continue|default|defer|else|fallthrough|for|func|go(?:to)?|if|import|interface|map|package|range|return|select|struct|switch|type|var)\\b"
                    ))
                ),
                Prism.token("boolean", Prism.pattern(Regex("\\b(?:_|iota|nil|true|false)\\b"))),
                Prism.token(
                    "operator",
                    Prism.pattern(
                        Regex(
                        "[*\\/%^!=]=?|\\+[=+]?|-[=-]?|\\|[=|]?|&(?:=|&|\\^=?)?|>(?:>=?|=)?|<(?:<=?|=|-)?|:=|\\.\\.\\."))
                ),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                            "(?:\\b0x[a-f\\d]+|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:e[-+]?\\d+)?)i?",
                            RegexOption().ignoreCase()
                        )
                    )
                ),
                Prism.token(
                    "string",
                    Prism.pattern(
                        Regex("([\"'`])(\\\\[\\s\\S]|(?!\\1)[^\\\\])*\\1"),
                        false,
                        true
                    )
                )
            )
        )

        // clike doesn't have builtin
        GrammarUtils.insertBeforeToken(
            go,
            "boolean",
            ArrayList<Token>(
                Prism.token(
                    "builtin",
                    Prism.pattern(
                        Regex(
                        "\\b(?:bool|byte|complex(?:64|128)|error|float(?:32|64)|rune|string|u?int(?:8|16|32|64)?|uintptr|append|cap|close|complex|copy|delete|imag|len|make|new|panic|print(?:ln)?|real|recover)\\b"
                    ))
                )
            )
        )

        return go
    }