    public func append(command: KeepCommand<T>): Unit {
        commands.append(command)
        lcsLength++
    }