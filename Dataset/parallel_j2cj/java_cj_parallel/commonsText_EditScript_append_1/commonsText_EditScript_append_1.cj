    public func append(command: InsertCommand<T>): Unit {
        commands.append(command)
        modifications++
    }