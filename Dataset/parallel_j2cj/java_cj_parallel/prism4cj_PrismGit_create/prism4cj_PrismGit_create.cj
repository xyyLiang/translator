    public static func create(): Grammar {
        return GrammarImpl(
            "git",
            ArrayList<Token>(
                Prism.token("comment", Prism.pattern(Regex("^#.*", RegexOption().ignoreCase()))),
                Prism.token("deleted", Prism.pattern(Regex("^[-–].*", RegexOption().ignoreCase()))),
                Prism.token("inserted", Prism.pattern(Regex("^\\+.*", RegexOption().ignoreCase()))),
                Prism.token(
                    "string",
                    Prism.pattern(Regex("(\"|')(?:\\\\.|(?!\\1)[^\\\\\\r\\n])*\\1", RegexOption().ignoreCase()))
                ),
                Prism.token(
                    "command",
                    Prism.pattern(
                        Regex("^.*\\$ git .*$", RegexOption().ignoreCase()),
                        false,
                        false,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(
                                Prism.token("parameter", Prism.pattern(Regex("\\s--?\\w+", RegexOption().ignoreCase())))
                            )
                        )
                    )
                ),
                Prism.token("coord", Prism.pattern(Regex("^@@.*@@$", RegexOption().ignoreCase()))),
                Prism.token("commit_sha1", Prism.pattern(Regex("^commit \\w{40}$", RegexOption().ignoreCase())))
            )
        )
    }