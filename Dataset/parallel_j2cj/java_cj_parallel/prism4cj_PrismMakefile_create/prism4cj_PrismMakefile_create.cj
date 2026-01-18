    public static func create(): Grammar {
        return GrammarImpl(
            "makefile",
            ArrayList<Token>(
                Prism.token(
                    "comment",
                    Prism.pattern(
                        Regex("(^|[^\\\\])#(?:\\\\(?:\\r\\n|[\\s\\S])|[^\\\\\\r\\n])*"),
                        true
                    )
                ),
                Prism.token(
                    "string",
                    Prism.pattern(
                        Regex("([\"'])(?:\\\\(?:\\r\\n|[\\s\\S])|(?!\\1)[^\\\\\\r\\n])*\\1"),
                        false,
                        true
                    )
                ),
                Prism.token("builtin", Prism.pattern(Regex("\\.[A-Z][^:#=\\s]+(?=\\s*:(?!=))"))),
                Prism.token(
                    "symbol",
                    Prism.pattern(
                        Regex("^[^:=\\r\\n]+(?=\\s*:(?!=))", RegexOption().multiLine()),
                        false,
                        false,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(
                                Prism.token("variable", Prism.pattern(Regex("\\$+(?:[^(){}:#=\\s]+|(?=[({]))"))))
                        )
                    )
                ),
                Prism.token("variable", Prism.pattern(Regex("\\$+(?:[^(){}:#=\\s]+|\\([@*%<^+?][DF]\\)|(?=[({]))"))),
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                        "-include\\b|\\b(?:define|else|endef|endif|export|ifn?def|ifn?eq|include|override|private|sinclude|undefine|unexport|vpath)\\b"
                    )),
                    Prism.pattern(
                        Regex(
                            "(\\()(?:addsuffix|abspath|and|basename|call|dir|error|eval|file|filter(?:-out)?|findstring|firstword|flavor|foreach|guile|if|info|join|lastword|load|notdir|or|origin|patsubst|realpath|shell|sort|strip|subst|suffix|value|warning|wildcard|word(?:s|list)?)(?=[ \\t])"
                        ),
                        true
                    )
                ),
                Prism.token("operator", Prism.pattern(Regex("(?:::|[?:+!])?=|[|@]"))),
                Prism.token("punctuation", Prism.pattern(Regex("[:;(){}]")))
            )
        )
    }