    public func toString(): String {
        var buf: StringBuilder =  StringBuilder("[")
        var node: Option<PathNode> = this
        while (!checkNull(node)) {
            buf.append("(")
            buf.append(node.getOrThrow().i)
            buf.append(",")
            buf.append(node.getOrThrow().j)
            buf.append(")")
            node = node.getOrThrow().prev
        }
        buf.append("]");
        return buf.toString()
    }