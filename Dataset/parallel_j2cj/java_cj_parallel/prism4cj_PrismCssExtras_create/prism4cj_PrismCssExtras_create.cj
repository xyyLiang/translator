    public static func create(): ?Grammar {
        let css: ?Grammar = GrammarImpl("css")
        if (let Some(v) <- css) {
            let selector: ?Token = GrammarUtils.findToken(v, "selector")
            if (let Some(m) <- selector) {
                let pattern: Pattern = Prism.pattern(
                    Regex("[^{}\\s][^{}]*(?=\\s*\\{)"),
                    false,
                    false,
                    None,
                    GrammarImpl(
                        "inside",
                        ArrayList<Token>(
                            Prism.token(
                                "pseudo-element",
                                Prism.pattern(Regex(":(?:after|before|first-letter|first-line|selection)|::[-\\w]+"))
                            ),
                            Prism.token("pseudo-class", Prism.pattern(Regex(":[-\\w]+(?:\\(.*\\))?"))),
                            Prism.token("class", Prism.pattern(Regex("\\.[-:.\\w]+"))),
                            Prism.token("id", Prism.pattern(Regex("#[-:.\\w]+"))),
                            Prism.token("attribute", Prism.pattern(Regex("\\[[^\\]]+\\]")))
                        )
                    )
                )
                m.patterns().clear()
                m.patterns().append(pattern)
            }

            GrammarUtils.insertBeforeToken(
                v,
                "function",
                ArrayList<Token>(
                    Prism.token("hexcode", Prism.pattern(Regex("#[\\da-f]{3,8}", RegexOption().ignoreCase()))),
                    Prism.token("entity", Prism.pattern(Regex("\\\\[\\da-f]{1,8}", RegexOption().ignoreCase()))),
                    Prism.token("number", Prism.pattern(Regex("[\\d%.]+")))
                )
            )
        }
        return None
    }