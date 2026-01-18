    public static func create(): Grammar {
        let funcPattern: Regex = Regex("\\\\(?:[^a-z()\\[\\]]|[a-z*]+)", RegexOption().ignoreCase())

        let insideEqu: Grammar = GrammarImpl(
            "inside",
            ArrayList<Token>(Prism.token("equation-command", Prism.pattern(funcPattern, false, false, "regex")))
        )

        return GrammarImpl(
            "latex",
            ArrayList<Token>(
                Prism.token("comment", Prism.pattern(Regex("%.*", RegexOption().multiLine()))),
                Prism.token(
                    "cdata",
                    Prism.pattern(
                        Regex("(\\\\begin\\{((?:verbatim|lstlisting)\\*?)\\})[\\s\\S]*?(?=\\\\end\\{\\2\\})"),
                        true
                    )
                ),
                Prism.token(
                    "equation",
                    Prism.pattern(
                        Regex("\\$(?:\\\\[\\s\\S]|[^\\\\$])*\\$|\\\\\\([\\s\\S]*?\\\\\\)|\\\\\\[[\\s\\S]*?\\\\\\]"),
                        false,
                        false,
                        "string",
                        insideEqu
                    ),
                    Prism.pattern(
                        Regex(
                            "(\\\\begin\\{((?:equation|math|eqnarray|align|multline|gather)\\*?)\\})[\\s\\S]*?(?=\\\\end\\{\\2\\})"
                        ),
                        true,
                        false,
                        "string",
                        insideEqu
                    )
                ),
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                            "(\\\\(?:begin|end|ref|cite|label|usepackage|documentclass)(?:\\[[^\\]]+\\])?\\{)[^}]+(?=\\})"
                        ),
                        true
                    )
                ),
                Prism.token(
                    "url",
                    Prism.pattern(
                        Regex("(\\\\url\\{)[^}]+(?=\\})"),
                        true
                    )
                ),
                Prism.token(
                    "headline",
                    Prism.pattern(
                        Regex(
                            "(\\\\(?:part|chapter|section|subsection|frametitle|subsubsection|paragraph|subparagraph|subsubparagraph|subsubsubparagraph)\\*?(?:\\[[^\\]]+\\])?\\{)[^}]+(?=\\}(?:\\[[^\\]]+\\])?)"
                        ),
                        true,
                        false,
                        "class-name"
                    )
                ),
                Prism.token(
                    "function",
                    Prism.pattern(
                        funcPattern,
                        false,
                        false,
                        "selector"
                    )
                ),
                Prism.token("punctuation", Prism.pattern(Regex("[\\[\\]{}&]")))
            )
        )
    }