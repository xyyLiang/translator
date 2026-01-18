    private static func isGreedyNode(node: Node): Bool {
        return node.isSyntax() && (node as Syntax).getOrThrow().greedy()
    }