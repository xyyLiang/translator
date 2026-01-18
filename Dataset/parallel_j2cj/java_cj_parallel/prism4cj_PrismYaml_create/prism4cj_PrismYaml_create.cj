    public static func create(): Grammar {
        return GrammarImpl(
            "yaml",
            ArrayList<Token>(
                Prism.token(
                    "scalar",
                    Prism.pattern(
                        Regex(
                            "([\\-:]\\s*(?:![^\\s]+)?[ \\t]*[|>])[ \\t]*(?:((?:\\r?\\n|\\r)[ \\t]+)[^\\r\\n]+(?:\\2[^\\r\\n]+)*)"
                        ),
                        true,
                        false,
                        "string"
                    )
                ),
                Prism.token("comment", Prism.pattern(Regex("#.*"))),
                Prism.token(
                    "key",
                    Prism.pattern(
                        Regex(
                            "(\\s*(?:^|[:\\-,\\[{\\r\\n?])[ \\t]*(?:![^\\s]+)?[ \\t]*)[^\\r\\n{\\[\\]},#\\s]+?(?=\\s*:\\s)"
                        ),
                        true,
                        false,
                        "atrule"
                    )
                ),
                Prism.token(
                    "directive",
                    Prism.pattern(
                        Regex("(^[ \\t]*)%.+", RegexOption().multiLine()),
                        true,
                        false,
                        "important"
                    )
                ),
                Prism.token(
                    "datetime",
                    Prism.pattern(
                        Regex(
                            "([:\\-,\\[{]\\s*(?:![^\\s]+)?[ \\t]*)(?:\\d{4}-\\d\\d?-\\d\\d?(?:[tT]|[ \\t]+)\\d\\d?:\\d{2}:\\d{2}(?:\\.\\d*)?[ \\t]*(?:Z|[-+]\\d\\d?(?::\\d{2})?)?|\\d{4}-\\d{2}-\\d{2}|\\d\\d?:\\d{2}(?::\\d{2}(?:\\.\\d*)?)?)(?=[ \\t]*(?:$|,|]|\\}))",
                            RegexOption().multiLine()
                        ),
                        true,
                        false,
                        "number"
                    )
                ),
                Prism.token(
                    "boolean",
                    Prism.pattern(
                        Regex(
                            "([:\\-,\\[{]\\s*(?:![^\\s]+)?[ \\t]*)(?:true|false)[ \\t]*(?=$|,|]|\\})",
                            RegexOption().multiLine()
                        ),
                        true,
                        false,
                        "important"
                    )
                ),
                Prism.token(
                    "None",
                    Prism.pattern(
                        Regex(
                            "([:\\-,\\[{]\\s*(?:![^\\s]+)?[ \\t]*)(?:None|~)[ \\t]*(?=$|,|]|\\})",
                            RegexOption().multiLine()
                        ),
                        true,
                        false,
                        "important"
                    )
                ),
                Prism.token(
                    "string",
                    Prism.pattern(
                        Regex(
                            "([:\\-,\\[{]\\s*(?:![^\\s]+)?[ \\t]*)(\"|')(?:(?!\\2)[^\\\\\\r\\n]|\\\\.)*\\2(?=[ \\t]*(?:$|,|]|\\}))",
                            RegexOption().multiLine()
                        ),
                        true,
                        true
                    )
                ),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                            "([:\\-,\\[{]\\s*(?:![^\\s]+)?[ \\t]*)[+-]?(?:0x[\\da-f]+|0o[0-7]+|(?:\\d+\\.?\\d*|\\.?\\d+)(?:e[+-]?\\d+)?|\\.inf|\\.nan)[ \\t]*(?=$|,|]|\\})",
                            RegexOption().multiLine()
                        ),
                        true
                    )
                ),
                Prism.token("tag", Prism.pattern(Regex("![^\\s]+"))),
                Prism.token("important", Prism.pattern(Regex("[&*][\\w]+"))),
                Prism.token("punctuation", Prism.pattern(Regex("---|[:\\[\\]{}\\-,|>?]|\\.\\.\\.")))
            )
        )
    }