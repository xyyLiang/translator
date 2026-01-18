    @Override
    public String toString() {
        StringBuilder buf = new StringBuilder("[");
        PathNode node = this;
        while (node != null) {
            buf.append("(");
            buf.append(node.i);
            buf.append(",");
            buf.append(node.j);
            buf.append(")");
            node = node.prev;
        }
        buf.append("]");
        return buf.toString();
    }