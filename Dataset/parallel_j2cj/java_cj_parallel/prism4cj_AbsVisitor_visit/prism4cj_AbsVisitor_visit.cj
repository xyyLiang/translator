    public override func visit(nodes: ArrayList<Node>): Unit {
        for (i in 0..nodes.size) {
            if (nodes[i].isSyntax()) {
                visitSyntax((nodes[i] as Syntax).getOrThrow())
            } else {
                visitText((nodes[i] as Text).getOrThrow())
            }
        }
    }