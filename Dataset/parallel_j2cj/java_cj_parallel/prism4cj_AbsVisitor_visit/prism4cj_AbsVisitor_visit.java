    public void visit(@NotNull List<? extends Prism4j.Node> nodes) {
        for (Prism4j.Node node : nodes) {
            if (node.isSyntax()) {
                visitSyntax((Prism4j.Syntax) node);
            } else {
                visitText((Prism4j.Text) node);
            }
        }
    }