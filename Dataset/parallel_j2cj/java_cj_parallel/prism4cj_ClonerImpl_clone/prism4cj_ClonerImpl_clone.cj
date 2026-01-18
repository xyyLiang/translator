    protected func clone(grammar: Grammar): Grammar {
        return clone(ContextImpl(), grammar)
    }