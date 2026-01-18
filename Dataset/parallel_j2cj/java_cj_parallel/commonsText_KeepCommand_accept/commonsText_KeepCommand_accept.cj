    public override func accept(visitor: CommandVisitor<T>): Unit {
        visitor.visitKeepCommand(getObject())
    }