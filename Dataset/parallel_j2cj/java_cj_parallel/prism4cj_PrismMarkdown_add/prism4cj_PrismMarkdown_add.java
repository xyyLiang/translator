  private static void add(@Nullable Prism4j.Grammar grammar, @NotNull Prism4j.Token first, @NotNull Prism4j.Token second) {
    if (grammar != null) {
      grammar.tokens().add(first);
      grammar.tokens().add(second);
    }
  }