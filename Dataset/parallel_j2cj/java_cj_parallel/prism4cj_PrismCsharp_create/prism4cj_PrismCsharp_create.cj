    public static func create(prism: Prism): Grammar {
        let classNameInsidePunctuation: Grammar = GrammarImpl(
            "inside",
            ArrayList<Token>(
                Prism.token(
                    "punctuation",
                    Prism.pattern(Regex("\\."))
                )
            )
        )

        let csharp: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "csharp",
            ArrayList<Token>(
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                        "\\b(?:abstract|add|alias|as|ascending|async|await|base|bool|break|byte|case|catch|char|checked|class|const|continue|decimal|default|delegate|descending|do|double|dynamic|else|enum|event|explicit|extern|false|finally|fixed|float|for|foreach|from|get|global|goto|group|if|implicit|in|int|interface|internal|into|is|join|let|lock|long|namespace|new|null|object|operator|orderby|out|override|params|partial|private|protected|public|readonly|ref|remove|return|sbyte|sealed|select|set|short|sizeof|stackalloc|static|string|struct|switch|this|throw|true|try|typeof|uint|ulong|unchecked|unsafe|ushort|using|value|var|virtual|void|volatile|where|while|yield)\\b"
                    ))
                ),
                Prism.token(
                    "string",
                    Prism.pattern(Regex("@(\"|')(?:\\1\\1|\\\\[\\s\\S]|(?!\\1)[^\\\\])*\\1"), false, true),
                    Prism.pattern(Regex("(\"|')(?:\\\\.|(?!\\1)[^\\\\\\r\\n])*?\\1"), false, true)
                ),
                Prism.token(
                    "class-name",
                    Prism.pattern(
                        Regex("\\b[A-Z]\\w*(?:\\.\\w+)*\\b(?=\\s+\\w+)"),
                        false,
                        false,
                        None
                    ),
                    Prism.pattern(
                        Regex("(\\[)[A-Z]\\w*(?:\\.\\w+)*\\b"),
                        true,
                        false,
                        None,
                        classNameInsidePunctuation
                    ),
                    Prism.pattern(
                        Regex("((?:\\b(?:class|interface|new)\\s+)|(?:catch\\s+\\())[A-Z]\\w*(?:\\.\\w+)*\\b"),
                        true,
                        false,
                        None,
                        classNameInsidePunctuation
                    ),
                    Prism.pattern(
                        Regex("((?:\\b(?:class|interface|new)\\s+)|(?:catch\\s+\\())[A-Z]\\w*(?:\\.\\w+)*\\b"),
                        true,
                        false,
                        None,
                        classNameInsidePunctuation
                    )
                ),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex("\\b0x[\\da-f]+\\b|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)f?", RegexOption().ignoreCase()))
                )
            )
        )

        GrammarUtils.insertBeforeToken(
            csharp,
            "class-name",
            ArrayList<Token>(
                Prism.token(
                    "generic-method",
                    Prism.pattern(
                        Regex("\\w+\\s*<[^>\\r\\n]+?>\\s*(?=\\()"),
                        false,
                        false,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(
                                Prism.token("function", Prism.pattern(Regex("^\\w+"))),
                                Prism.token(
                                    "class-name",
                                    Prism.pattern(Regex("\\b[A-Z]\\w*(?:\\.\\w+)*\\b"), false, false, None,
                                        classNameInsidePunctuation)
                                ),
                                Prism.token("punctuation", Prism.pattern(Regex("[<>(),.:]"))),
                                GrammarUtils.findToken(csharp, "keyword").getOrThrow()
                            )
                        ),
                    )
                ),
                Prism.token(
                    "preprocessor",
                    Prism.pattern(
                        Regex("(^\\s*)#.*", RegexOption().multiLine()),
                        true,
                        false,
                        "property",
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(
                                Prism.token(
                                    "directive",
                                    Prism.pattern(
                                        Regex(
                                            "(\\s*#)\\b(?:define|elif|else|endif|endregion|error|if|line|pragma|region|undef|warning)\\b"
                                        ),
                                        true,
                                        false,
                                        "keyword"
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
        return csharp
    }