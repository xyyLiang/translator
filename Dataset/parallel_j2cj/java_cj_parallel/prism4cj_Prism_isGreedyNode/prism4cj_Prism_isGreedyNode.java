    private static boolean isGreedyNode(@NotNull Node node) {
        return node.isSyntax() && ((Syntax) node).greedy();
    }