    public func tokenize(text: String, grammar: Grammar): ArrayList<Node> {
        var entries: ArrayList<Node> = ArrayList<Node>(3)
        entries.append(TextImpl(text))
        matchGrammar(text, entries, grammar, 0, 0, false, None)
        return entries
    }