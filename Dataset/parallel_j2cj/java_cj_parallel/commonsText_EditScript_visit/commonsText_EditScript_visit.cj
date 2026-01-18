    public func visit(visitor: CommandVisitor<T>): Unit {
        for (command in commands) {
            command.accept(visitor)
        }
    }