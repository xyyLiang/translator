    public static func create(prism: Prism): Grammar {
        let swift: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "swift",
            ArrayList<Token>(
                Prism.token(
                    "string",
                    Prism.pattern(
                        Regex("(\"|')(\\\\(?:\\((?:[^()]|\\([^)]+\\))+\\)|\\r\\n|[\\s\\S])|(?!\\1)[^\\\\\\r\\n])*\\1"),
                        false,
                        true,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(
                                Prism.token(
                                    "interpolation",
                                    Prism.pattern(
                                        Regex("\\\\\\((?:[^()]|\\([^)]+\\))+\\)"),
                                        false,
                                        false,
                                        None,
                                        GrammarImpl(
                                            "inside",
                                            ArrayList<Token>(
                                                Prism.token(
                                                    "delimiter",
                                                    Prism.pattern(
                                                        Regex("^\\\\\\(|\\)$"),
                                                        false,
                                                        false,
                                                        "variable"
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                ),
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                        "\\b(?:as|associativity|break|case|catch|class|continue|convenience|default|defer|deinit|didSet|do|dynamic(?:Type)?|else|enum|extension|fallthrough|final|for|func|get|guard|if|import|in|infix|init|inout|internal|is|lazy|left|let|mutating|new|none|nonmutating|operator|optional|override|postfix|precedence|prefix|private|protocol|public|repeat|required|rethrows|return|right|safe|self|Self|set|static|struct|subscript|super|switch|throws?|try|Type|typealias|unowned|unsafe|var|weak|where|while|willSet|__(?:COLUMN__|FILE__|FUNCTION__|LINE__))\\b"
                    ))
                ),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                            "\\b(?:[\\d_]+(?:\\.[\\de_]+)?|0x[a-f0-9_]+(?:\\.[a-f0-9p_]+)?|0b[01_]+|0o[0-7_]+)\\b",
                            RegexOption().ignoreCase()
                        )
                    )
                )
            )
        )

        let tokens: ArrayList<Token> = swift.tokens()

        tokens.append(Prism.token("constant", Prism.pattern(Regex("\\b(?:nil|[A-Z_]{2,}|k[A-Z][A-Za-z_]+)\\b"))))
        tokens.append(
            Prism.token(
                "atrule",
                Prism.pattern(
                    Regex(
                    "@\\b(?:IB(?:Outlet|Designable|Action|Inspectable)|class_protocol|exported|noreturn|NS(?:Copying|Managed)|objc|UIApplicationMain|auto_closure)\\b"
                ))
            )
        )
        tokens.append(
            Prism.token(
                "builtin",
                Prism.pattern(
                    Regex(
                    "\\b(?:[A-Z]\\S+|abs|advance|alignof(?:Value)?|assert|contains|count(?:Elements)?|debugPrint(?:ln)?|distance|drop(?:First|Last)|dump|enumerate|equal|filter|find|first|getVaList|indices|isEmpty|join|last|lexicographicalCompare|map|max(?:Element)?|min(?:Element)?|numericCast|overlaps|partition|print(?:ln)?|reduce|reflect|reverse|sizeof(?:Value)?|sort(?:ed)?|split|startsWith|stride(?:of(?:Value)?)?|suffix|swap|toDebugString|toString|transcode|underestimateCount|unsafeBitCast|with(?:ExtendedLifetime|Unsafe(?:MutablePointers?|Pointers?)|VaList))\\b"
                ))
            )
        )

        let interpolationToken: ?Token = GrammarUtils.findToken(swift, "string/interpolation")
        let interpolationGrammar: ?Grammar = if (let Some(v) <- interpolationToken) {
            GrammarUtils.findFirstInsideGrammar(v)
        } else {
            None
        }
        if (let Some(v) <- interpolationGrammar) {
            v.tokens().appendAll(swift.tokens())
        }

        return swift
    }