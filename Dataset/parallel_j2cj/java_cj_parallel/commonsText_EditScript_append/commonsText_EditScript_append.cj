    public func append(command: DeleteCommand<T>): Unit {
        commands.append(command)
        modifications++
    }