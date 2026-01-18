    public static func create(prism: Prism): Grammar {
        let kotlin: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "kotlin",
            TokenFilterKotlinImpl(),
            ArrayList<Token>(
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                            "(^|[^.])\\b(?:abstract|actual|annotation|as|break|by|catch|class|companion|const|constructor|continue|crossinline|data|do|dynamic|else|enum|expect|external|final|finally|for|fun|get|if|import|in|infix|init|inline|inner|interface|internal|is|lateinit|noinline|null|object|open|operator|out|override|package|private|protected|public|reified|return|sealed|set|super|suspend|tailrec|this|throw|to|try|typealias|val|var|vararg|when|where|while)\\b"
                        ),
                        true
                    )
                ),
                Prism.token(
                    "function",
                    Prism.pattern(Regex("\\w+(?=\\s*\\()")),
                    Prism.pattern(Regex("(\\.)\\w+(?=\\s*\\{)"), true)
                ),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                        "\\b(?:0[xX][\\da-fA-F]+(?:_[\\da-fA-F]+)*|0[bB][01]+(?:_[01]+)*|\\d+(?:_\\d+)*(?:\\.\\d+(?:_\\d+)*)?(?:[eE][+-]?\\d+(?:_\\d+)*)?[fFL]?)\\b"
                    ))
                ),
                Prism.token(
                    "operator",
                    Prism.pattern(
                        Regex(
                        "\\+[+=]?|-[-=>]?|==?=?|!(?:!|==?)?|[\\/*%<>]=?|[?:]:?|\\.\\.|&&|\\|\\||\\b(?:and|inv|or|shl|shr|ushr|xor)\\b"
                    ))
                )
            )
        )

        GrammarUtils.insertBeforeToken(kotlin, "string",
            ArrayList<Token>(
            Prism.token("raw-string", Prism.pattern(Regex("(\"\"\"|''')[\\s\\S]*?\\1"), false, false, "string"))))

        GrammarUtils.insertBeforeToken(
            kotlin,
            "keyword",
            ArrayList<Token>(
                Prism.token(
                    "annotation",
                    Prism.pattern(Regex("\\B@(?:\\w+:)?(?:[A-Z]\\w*|\\[[^\\]]+\\])"), false, false, "builtin")
                )
            )
        )

        GrammarUtils.insertBeforeToken(kotlin, "function",
            ArrayList<Token>(Prism.token("label", Prism.pattern(Regex("\\w+@|@\\w+"), false, false, "symbol"))))

        // this grammar has 1 token: interpolation, which has 2 patterns
        let interpolationInside: Grammar
        let tokens: ArrayList<Token> = ArrayList<Token>(kotlin.tokens().size + 1)
        tokens.append(Prism.token("delimiter", Prism.pattern(Regex("^\\$\\{|\\}$"), false, false, "variable")))
        tokens.appendAll(kotlin.tokens())

        interpolationInside = GrammarImpl(
            "inside",
            ArrayList<Token>(
                Prism.token(
                    "interpolation",
                    Prism.pattern(Regex("\\$\\{[^}]+\\}"), false, false, None, GrammarImpl("inside", tokens)),
                    Prism.pattern(Regex("\\$\\w+"), false, false, "variable")
                )
            )
        )

        let string: ?Token = GrammarUtils.findToken(kotlin, "string")
        let rawString: ?Token = GrammarUtils.findToken(kotlin, "raw-string")

        if (string.isSome() && rawString.isSome()) {
            let strValue = string.getOrThrow()
            let rawStrValue = rawString.getOrThrow()
            let stringPattern: Pattern = strValue.patterns()[0]
            let rawStringPattern: Pattern = rawStrValue.patterns()[0]

            strValue.patterns().append(
                Prism.pattern(stringPattern.regex(), stringPattern.lookbehind(), stringPattern.greedy(),
                stringPattern.alias(), interpolationInside))

            rawStrValue.patterns().append(
                Prism.pattern(rawStringPattern.regex(), rawStringPattern.lookbehind(), rawStringPattern.greedy(),
                rawStringPattern.alias(), interpolationInside))

            strValue.patterns().remove(0)
            rawStrValue.patterns().remove(0)
        } else {
            throw Exception(
                "Unexpected state, cannot find `string` and/or `raw-string` tokens " + "inside kotlin grammar")
        }

        return kotlin
    }