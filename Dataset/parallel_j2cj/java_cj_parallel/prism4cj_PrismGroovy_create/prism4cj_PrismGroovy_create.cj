    public static func create(prism: Prism): Grammar {
        let groovy: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "groovy",
            ArrayList<Token>(
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                        "\\b(?:as|def|in|abstract|assert|boolean|break|byte|case|catch|char|class|const|continue|default|do|double|else|enum|extends|final|finally|float|for|goto|if|implements|import|instanceof|int|interface|long|native|new|package|private|protected|public|return|short|static|strictfp|super|switch|synchronized|this|throw|throws|trait|transient|try|void|volatile|while)\\b"
                    ))
                ),
                Prism.token(
                    "string",
                    Prism.pattern(Regex("(\"\"\"|''')[\\s\\S]*?\\1|(?:\\$\\/)(?:\\$\\/\\$|[\\s\\S])*?\\/\\$"), false,
                        true),
                    Prism.pattern(Regex("([\"'\\/])(?:\\\\.|(?!\\1)[^\\\\\\r\\n])*\\1"), false, true)
                ),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                            "\\b(?:0b[01_]+|0x[\\da-f_]+(?:\\.[\\da-f_p\\-]+)?|[\\d_]+(?:\\.[\\d_]+)?(?:e[+-]?[\\d]+)?)[glidf]?\\b",
                            RegexOption().ignoreCase()
                        )
                    )
                ),
                Prism.token(
                    "operator",
                    Prism.pattern(
                        Regex(
                            "(^|[^.])(?:~|==?~?|\\?[.:]?|\\*(?:[.=]|\\*=?)?|\\.[@&]|\\.\\.<|\\.{1,2}(?!\\.)|-[-=>]?|\\+[+=]?|!=?|<(?:<=?|=>?)?|>(?:>>?=?|=)?|&[&=]?|\\|[|=]?|\\/=?|\\^=?|%=?)"
                        ),
                        true
                    )
                ),
                Prism.token(
                    "punctuation",
                    Prism.pattern(Regex("\\.+|[{}\\[\\];(),:$]"))
                )
            )
        )

        GrammarUtils.insertBeforeToken(
            groovy,
            "string",
            ArrayList<Token>(
                Prism.token(
                    "shebang",
                    Prism.pattern(
                        Regex("#!.+"),
                        false,
                        false,
                        "comment"
                    )
                )
            )
        )

        GrammarUtils.insertBeforeToken(groovy, "punctuation",
            ArrayList<Token>(
            Prism.token("spock-block", Prism.pattern(Regex("\\b(?:setup|given|when|then|and|cleanup|expect|where):")))))

        GrammarUtils.insertBeforeToken(
            groovy,
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

        // no string templates :(
        return groovy
    }