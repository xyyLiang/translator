    public static func create(prism: Prism): Grammar {
        let keyword: Token = Prism.token(
            "keyword",
            Prism.pattern(
                Regex(
                "\\b(?:abstract|continue|for|new|switch|assert|default|goto|package|synchronized|boolean|do|if|private|this|break|double|implements|protected|throw|byte|else|import|public|throws|case|enum|instanceof|return|transient|catch|extends|int|short|try|char|final|interface|static|void|class|finally|long|strictfp|volatile|const|float|native|super|while)\\b"
            ))
        )

        let java: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "java",
            ArrayList<Token>(
                keyword,
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                            "\\b0b[01]+\\b|\\b0x[\\da-f]*\\.?[\\da-fp-]+\\b|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:e[+-]?\\d+)?[df]?",
                            RegexOption().ignoreCase()
                        )
                    )
                ),
                Prism.token(
                    "operator",
                    Prism.pattern(
                        Regex(
                            "(^|[^.])(?:\\+[+=]?|-[-=]?|!=?|<<?=?|>>?>?=?|==?|&[&=]?|\\|[|=]?|\\*=?|\\/=?|%=?|\\^=?|[?:~])",
                            RegexOption().multiLine()
                        ),
                        true
                    )
                )
            )
        )

        GrammarUtils.insertBeforeToken(
            java,
            "function",
            ArrayList<Token>(
                Prism.token(
                    "annotation",
                    Prism.pattern(
                        Regex("(^|[^.])@\\w+"),
                        true,
                        false,
                        "punctuation"
                    )
                )
            )
        )

        GrammarUtils.insertBeforeToken(
            java,
            "class-name",
            ArrayList<Token>(
                Prism.token(
                    "generics",
                    Prism.pattern(
                        Regex("<\\s*\\w+(?:\\.\\w+)?(?:\\s*,\\s*\\w+(?:\\.\\w+)?)*>", RegexOption().ignoreCase()),
                        false,
                        false,
                        "function",
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(
                                keyword,
                                Prism.token("punctuation", Prism.pattern(Regex("[<>(),.:]")))
                            )
                        )
                    )
                )
            )
        )

        return java
    }