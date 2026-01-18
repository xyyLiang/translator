    public static func create(prism: Prism): Grammar {
        let js: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "javascript",
            ArrayList<Token>(
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                        "\\b(?:as|async|await|break|case|catch|class|const|continue|debugger|default|delete|do|else|enum|export|extends|finally|for|from|function|get|if|implements|import|in|instanceof|interface|let|new|null|of|package|private|protected|public|return|set|static|super|switch|this|throw|try|typeof|var|void|while|with|yield)\\b"
                    ))
                ),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                        "\\b(?:0[xX][\\dA-Fa-f]+|0[bB][01]+|0[oO][0-7]+|NaN|Infinity)\\b|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:[Ee][+-]?\\d+)?"
                    ))
                ),
                Prism.token(
                    "function",
                    Prism.pattern(
                        Regex("[_$a-z\\xA0-\\uFFFF][$\\w\\xA0-\\uFFFF]*(?=\\s*\\()", RegexOption().ignoreCase()))
                ),
                Prism.token(
                    "operator",
                    Prism.pattern(
                        Regex(
                        "-[-=]?|\\+[+=]?|!=?=?|<<?=?|>>?>?=?|=(?:==?|>)?|&[&=]?|\\|[|=]?|\\*\\*?=?|\\/=?|~|\\^=?|%=?|\\?|\\.{3}"
                    ))
                )
            )
        )

        GrammarUtils.insertBeforeToken(
            js,
            "keyword",
            ArrayList<Token>(
                Prism.token(
                    "regex",
                    Prism.pattern(
                        Regex(
                            "((?:^|[^$\\w\\xA0-\\uFFFF.\"'\\])\\s])\\s*)\\/(\\[[^\\]\\r\\n]+]|\\\\.|[^/\\\\\\[\\r\\n])+\\/[gimyu]{0,5}(?=\\s*($|[\\r\\n,.;})\\]]))"
                        ),
                        true,
                        true
                    )
                ),
                Prism.token(
                    "function-variable",
                    Prism.pattern(
                        Regex(
                            "[_$a-z\\xA0-\\uFFFF][$\\w\\xA0-\\uFFFF]*(?=\\s*=\\s*(?:function\\b|(?:\\([^()]*\\)|[_$a-z\\xA0-\\uFFFF][$\\w\\xA0-\\uFFFF]*)\\s*=>))",
                            RegexOption().ignoreCase()
                        ),
                        false,
                        false,
                        "function"
                    )
                ),
                Prism.token("constant", Prism.pattern(Regex("\\b[A-Z][A-Z\\d_]*\\b")))
            )
        )

        let interpolation: Token = Prism.token("interpolation")

        GrammarUtils.insertBeforeToken(
            js,
            "string",
            ArrayList<Token>(
                Prism.token(
                    "template-string",
                    Prism.pattern(
                        Regex("`(?:\\\\[\\s\\S]|\\$\\{[^}]+\\}|[^\\\\`])*`"),
                        false,
                        true,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(
                                interpolation,
                                Prism.token("string", Prism.pattern(Regex("[\\s\\S]+")))
                            )
                        )
                    )
                )
            )
        )

        let insideInterpolation: Grammar
        let tokens: ArrayList<Token> = ArrayList<Token>(js.tokens().size + 1)
        tokens.append(
            Prism.token(
                "interpolation-punctuation",
                Prism.pattern(Regex("^\\$\\{|\\}$"), false, false, "punctuation")
            )
        )
        tokens.appendAll(js.tokens())
        insideInterpolation = GrammarImpl("inside", tokens)

        interpolation.patterns().append(
            Prism.pattern(
                Regex("\\$\\{[^}]+\\}"),
                false,
                false,
                None,
                insideInterpolation
            )
        )

        let markup: ?Grammar = GrammarImpl("markup")
        if (let Some(v) <- markup) {
            GrammarUtils.insertBeforeToken(
                v,
                "tag",
                ArrayList<Token>(
                    Prism.token(
                        "script",
                        Prism.pattern(
                            Regex("(<script[\\s\\S]*?>)[\\s\\S]*?(?=<\\/script>)", RegexOption().ignoreCase()),
                            true,
                            true,
                            "language-javascript",
                            js
                        )
                    )
                )
            )
        }

        return js
    }