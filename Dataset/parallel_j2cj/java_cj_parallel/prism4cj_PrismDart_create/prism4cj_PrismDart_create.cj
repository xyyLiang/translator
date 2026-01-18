    public static func create(prism: Prism): ?Grammar {
        let dart: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "dart",
            ArrayList<Token>(
                Prism.token(
                    "string",
                    Prism.pattern(Regex("r?(\"\"\"|''')[\\s\\S]*?\\1"), false, true),
                    Prism.pattern(Regex("r?(\"|')(?:\\\\.|(?!\\1)[^\\\\\\r\\n])*\\1"), false, true)
                ),
                Prism.token(
                    "keyword",
                    Prism.pattern(Regex("\\b(?:async|sync|yield)\\*")),
                    Prism.pattern(
                        Regex(
                        "\\b(?:abstract|assert|async|await|break|case|catch|class|const|continue|default|deferred|do|dynamic|else|enum|export|external|extends|factory|final|finally|for|get|if|implements|import|in|library|new|null|operator|part|rethrow|return|set|static|super|switch|this|throw|try|typedef|var|void|while|with|yield)\\b"
                    ))
                ),
                Prism.token(
                    "operator",
                    Prism.pattern(
                        Regex(
                        "\\bis!|\\b(?:as|is)\\b|\\+\\+|--|&&|\\|\\||<<=?|>>=?|~(?:\\/=?)?|[+\\-*\\/%&^|=!<>]=?|\\?"))
                )
            )
        )

        GrammarUtils.insertBeforeToken(dart, "function",
            ArrayList<Token>(Prism.token("metadata", Prism.pattern(Regex("@\\w+"), false, false, "symbol"))))
        return dart
    }