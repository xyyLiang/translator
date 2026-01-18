    public static func create(prism: Prism): Grammar {
        let markdown: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "markup"),
            "markdown",
            None
        )

        let bold: Token = Prism.token(
            "bold",
            Prism.pattern(
                Regex("(^|[^\\\\])(\\*\\*|__)(?:(?:\\r?\\n|\\r)(?!\\r?\\n|\\r)|.)+?\\2"),
                true,
                false,
                None,
                GrammarImpl(
                    "inside",
                    ArrayList<Token>(Prism.token("punctuation", Prism.pattern(Regex("^\\*\\*|^__|\\*\\*$|__$"))))
                )
            )
        )

        let italic: Token = Prism.token(
            "italic",
            Prism.pattern(
                Regex("(^|[^\\\\])([*_])(?:(?:\\r?\\n|\\r)(?!\\r?\\n|\\r)|.)+?\\2"),
                true,
                false,
                None,
                GrammarImpl("inside", ArrayList<Token>(Prism.token("punctuation", Prism.pattern(Regex("^[*_]|[*_]$")))))
            )
        )

        let url: Token = Prism.token(
            "url",
            Prism.pattern(
                Regex("!?\\[[^\\]]+\\](?:\\([^\\s)]+(?:[\\t ]+\"(?:\\\\.|[^\"\\\\])*\")?\\)| ?\\[[^\\]\\n]*\\])"),
                false,
                false,
                None,
                GrammarImpl(
                    "inside",
                    ArrayList<Token>(
                        Prism.token("variable", Prism.pattern(Regex("(!?\\[)[^\\]]+(?=\\]$)"), true)),
                        Prism.token("string", Prism.pattern(Regex("\"(?:\\\\.|[^\"\\\\])*\"(?=\\)$)")))
                    )
                )
            )
        )

        GrammarUtils.insertBeforeToken(
            markdown,
            "prolog",
            ArrayList<Token>(
                Prism.token("blockquote", Prism.pattern(Regex("^>(?:[\\t ]*>)*", RegexOption().multiLine()))),
                Prism.token(
                    "code",
                    Prism.pattern(Regex("^(?: {4}|\\t).+", RegexOption().multiLine()), false, false, "keyword"),
                    Prism.pattern(Regex("``.+?``|`[^`\\n]+`"), false, false, "keyword")
                ),
                Prism.token(
                    "title",
                    Prism.pattern(
                        Regex("\\w+.*(?:\\r?\\n|\\r)(?:==+|--+)"),
                        false,
                        false,
                        "important",
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(Prism.token("punctuation", Prism.pattern(Regex("==+$|--+$"))))
                        )
                    ),
                    Prism.pattern(
                        Regex("(^\\s*)#+.+", RegexOption().multiLine()),
                        true,
                        false,
                        "important",
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(Prism.token("punctuation", Prism.pattern(Regex("^#+|#+$"))))
                        )
                    )
                ),
                Prism.token(
                    "hr",
                    Prism.pattern(
                        Regex("(^\\s*)([*-])(?:[\\t ]*\\2){2,}(?=\\s*$)", RegexOption().multiLine()),
                        true,
                        false,
                        "punctuation"
                    )
                ),
                Prism.token(
                    "list",
                    Prism.pattern(
                        Regex("(^\\s*)(?:[*+-]|\\d+\\.)(?=[\\t ].)", RegexOption().multiLine()),
                        true,
                        false,
                        "punctuation"
                    )
                ),
                Prism.token(
                    "url-reference",
                    Prism.pattern(
                        Regex(
                            "!?\\[[^\\]]+\\]:[\\t ]+(?:\\S+|<(?:\\\\.|[^>\\\\])+>)(?:[\\t ]+(?:\"(?:\\\\.|[^\"\\\\])*\"|'(?:\\\\.|[^'\\\\])*'|\\((?:\\\\.|[^)\\\\])*\\)))?"
                        ),
                        false,
                        false,
                        "url",
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(
                                Prism.token("variable", Prism.pattern(Regex("^(!?\\[)[^\\]]+"), true)),
                                Prism.token(
                                    "string",
                                    Prism.pattern(
                                        Regex(
                                        "(?:\"(?:\\\\.|[^\"\\\\])*\"|'(?:\\\\.|[^'\\\\])*'|\\((?:\\\\.|[^)\\\\])*\\))$")
                                    )
                                ),
                                Prism.token("punctuation", Prism.pattern(Regex("^[\\[\\]!:]|[<>]")))
                            )
                        )
                    )
                ),
                bold,
                italic,
                url
            )
        )

        add(GrammarUtils.findFirstInsideGrammar(bold), url, italic)
        add(GrammarUtils.findFirstInsideGrammar(italic), url, bold)
        return markdown
    }
