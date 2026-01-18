    public static func create(prism: Prism): Grammar {
        let c: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "c",
            TokenFilterCImpl(),
            ArrayList<Token>(
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                        "\\b(?:_Alignas|_Alignof|_Atomic|_Bool|_Complex|_Generic|_Imaginary|_Noreturn|_Static_assert|_Thread_local|asm|typeof|inline|auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while)\\b"
                    ))
                ),
                Prism.token(
                    "operator",
                    Prism.pattern(Regex("-[>-]?|\\+\\+?|!=?|<<?=?|>>?=?|==?|&&?|\\|\\|?|[~^%?*\\/]"))
                ),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                            "(?:\\b0x[\\da-f]+|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:e[+-]?\\d+)?)[ful]*",
                            RegexOption().ignoreCase()
                        )
                    )
                )
            )
        )

        GrammarUtils.insertBeforeToken(
            c,
            "string",
            ArrayList<Token>(
                Prism.token(
                    "marcro",
                    Prism.pattern(
                        Regex("(^\\s*)#\\s*[a-z]+(?:[^\\r\\n\\\\]|\\\\(?:\\r\\n|[\\s\\S]))*", RegexOption().multiLine()),
                        true,
                        false,
                        "property",
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(
                                Prism.token(
                                    "string",
                                    Prism.pattern(Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)"), true)
                                ),
                                Prism.token(
                                    "directive",
                                    Prism.pattern(
                                        Regex(
                                            "(#\\s*)\\b(?:define|defined|elif|else|endif|error|ifdef|ifndef|if|import|include|line|pragma|undef|using)\\b"
                                        ),
                                        true,
                                        false,
                                        "keyword"
                                    )
                                )
                            )
                        )
                    )
                ),
                Prism.token(
                    "constant",
                    Prism.pattern(
                        Regex(
                        "\\b(?:__FILE__|__LINE__|__DATE__|__TIME__|__TIMESTAMP__|__func__|EOF|NULL|SEEK_CUR|SEEK_END|SEEK_SET|stdin|stdout|stderr)\\b"
                    ))
                )
            )
        )
        return c
    }