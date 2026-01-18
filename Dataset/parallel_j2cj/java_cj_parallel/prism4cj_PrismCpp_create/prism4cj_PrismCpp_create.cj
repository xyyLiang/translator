    public static func create(prism: Prism): Grammar {
        let cpp: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "c"),
            "cpp",
            ArrayList<Token>(
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                        "\\b(?:alignas|alignof|asm|auto|bool|break|case|catch|char|char16_t|char32_t|class|compl|const|constexpr|const_cast|continue|decltype|default|delete|do|double|dynamic_cast|else|enum|explicit|export|extern|float|for|friend|goto|if|inline|int|int8_t|int16_t|int32_t|int64_t|uint8_t|uint16_t|uint32_t|uint64_t|long|mutable|namespace|new|noexcept|nullptr|operator|private|protected|public|register|reinterpret_cast|return|short|signed|sizeof|static|static_assert|static_cast|struct|switch|template|this|thread_local|throw|try|typedef|typeid|typename|union|unsigned|using|virtual|void|volatile|wchar_t|while)\\b"
                    ))
                ),
                Prism.token(
                    "operator",
                    Prism.pattern(
                        Regex(
                        "--?|\\+\\+?|!=?|<{1,2}=?|>{1,2}=?|->|:{1,2}|={1,2}|\\^|~|%|&{1,2}|\\|\\|?|\\?|\\*|\\/|\\b(?:and|and_eq|bitand|bitor|not|not_eq|or|or_eq|xor|xor_eq)\\b"
                    ))
                ),
            )
        )

        // in Prism-js cpp is extending c, but c has not booleans... (like classes)
        GrammarUtils.insertBeforeToken(cpp, "function",
            ArrayList<Token>(Prism.token("boolean", Prism.pattern(Regex("\\b(?:true|false)\\b")))))

        GrammarUtils.insertBeforeToken(
            cpp,
            "keyword",
            ArrayList<Token>(
                Prism.token(
                    "class-name",
                    Prism.pattern(Regex("(class\\s+)\\w+", RegexOption().ignoreCase()), true)
                )
            )
        )

        GrammarUtils.insertBeforeToken(
            cpp,
            "string",
            ArrayList<Token>(
                Prism.token(
                    "raw-string",
                    Prism.pattern(Regex("R\"([^()\\\\ ]{0,16})\\([\\s\\S]*?\\)\\1\""), false, true, "string")
                )
            )
        )
        return cpp
    }