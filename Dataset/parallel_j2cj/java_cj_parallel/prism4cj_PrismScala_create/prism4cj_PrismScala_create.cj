    public static func create(prism: Prism): Grammar {
        let scala: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "java"),
            "scala",
            TokenFilterScalaImpl(),
            ArrayList<Token>(
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                        "<-|=>|\\b(?:abstract|case|catch|class|def|do|else|extends|final|finally|for|forSome|if|implicit|import|lazy|match|new|null|object|override|package|private|protected|return|sealed|self|super|this|throw|trait|try|type|val|var|while|with|yield)\\b"
                    ))
                ),
                Prism.token(
                    "string",
                    Prism.pattern(Regex("\"\"\"[\\s\\S]*?\"\"\""), false, true),
                    Prism.pattern(Regex("(\"|')(?:\\\\.|(?!\\1)[^\\\\\\r\\n])*\\1"), false, true)
                ),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                            "\\b0x[\\da-f]*\\.?[\\da-f]+|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:e\\d+)?[dfl]?",
                            RegexOption().ignoreCase()
                        )
                    )
                )
            )
        )

        scala.tokens().append(Prism.token("symbol", Prism.pattern(Regex("'[^\\d\\s\\\\]\\w*"))))

        GrammarUtils.insertBeforeToken(
            scala,
            "number",
            ArrayList<Token>(
                Prism.token(
                    "builtin",
                    Prism.pattern(
                        Regex(
                        "\\b(?:String|Int|Long|Short|Byte|Boolean|Double|Float|Char|Any|AnyRef|AnyVal|Unit|Nothing)\\b")
                    )
                )
            )
        )

        return scala
    }