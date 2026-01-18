    public static func create(): Grammar {
        let entity: Token = Prism.token("entity", Prism.pattern(Regex("&#?[\\da-z]{1,8};", RegexOption().ignoreCase())));
        return GrammarImpl(
            "markup",
            ArrayList<Token>(
                Prism.token("comment", Prism.pattern(Regex("<!--[\\s\\S]*?-->"))),
                Prism.token("prolog", Prism.pattern(Regex("<\\?[\\s\\S]+?\\?>"))),
                Prism.token("doctype", Prism.pattern(Regex("<!DOCTYPE[\\s\\S]+?>", RegexOption().ignoreCase()))),
                Prism.token("cdata", Prism.pattern(Regex("<!\\[CDATA\\[[\\s\\S]*?]]>", RegexOption().ignoreCase()))),
                Prism.token(
                    "tag",
                    Prism.pattern(
                        Regex(
                            "<\\/?(?!\\d)[^\\s>\\/=$<%]+(?:\\s+[^\\s>\\/=]+(?:=(?:(\"|')(?:\\\\[\\s\\S]|(?!\\1)[^\\\\])*\\1|[^\\s'\">=]+))?)*\\s*\\/?>",
                            RegexOption().ignoreCase()
                        ),
                        false,
                        true,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(
                                Prism.token(
                                    "tag",
                                    Prism.pattern(
                                        Regex("^<\\/?[^\\s>\\/]+", RegexOption().ignoreCase()),
                                        false,
                                        false,
                                        None,
                                        GrammarImpl(
                                            "inside",
                                            ArrayList<Token>(
                                                Prism.token("punctuation", Prism.pattern(Regex("^<\\/?"))),
                                                Prism.token("namespace", Prism.pattern(Regex("^[^\\s>\\/:]+:")))
                                            )
                                        )
                                    )
                                ),
                                Prism.token(
                                    "attr-value",
                                    Prism.pattern(
                                        Regex(
                                            "=(?:(\"|')(?:\\\\[\\s\\S]|(?!\\1)[^\\\\])*\\1|[^\\s'\">=]+)",
                                            RegexOption().ignoreCase()
                                        ),
                                        false,
                                        false,
                                        None,
                                        GrammarImpl(
                                            "inside",
                                            ArrayList<Token>(
                                                Prism.token(
                                                    "punctuation",
                                                    Prism.pattern(Regex("^=")),
                                                    Prism.pattern(Regex("(^|[^\\\\])[\"']"), true)
                                                ),
                                                entity
                                            )
                                        )
                                    )
                                ),
                                Prism.token("punctuation", Prism.pattern(Regex("\\/?>"))),
                                Prism.token(
                                    "attr-name",
                                    Prism.pattern(
                                        Regex("[^\\s>\\/]+"),
                                        false,
                                        false,
                                        None,
                                        GrammarImpl(
                                            "inside",
                                            ArrayList<Token>(
                                                Prism.token("namespace", Prism.pattern(Regex("^[^\\s>\\/:]+:"))))
                                        )
                                    )
                                )
                            )
                        )
                    )
                ),
                entity
            )
        )
    }