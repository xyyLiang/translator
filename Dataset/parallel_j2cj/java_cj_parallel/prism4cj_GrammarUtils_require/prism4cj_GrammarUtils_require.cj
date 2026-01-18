    public static func require(prism: Prism, name: String): Grammar {
        let requireGrammar: ?Grammar = prism.grammar(name)
        if (requireGrammar.isNone()) {
            throw IllegalStateException("Unexpected state, requested language is not found: " + name)
        }
        return requireGrammar.getOrThrow()
    }