    @NotNull
    public List<Node> tokenize(@NotNull String text, @NotNull Grammar grammar) {
        final List<Node> entries = new ArrayList<>(3);
        entries.add(new TextImpl(text));
        matchGrammar(text, entries, grammar, 0, 0, false, null);
        return entries;
    }