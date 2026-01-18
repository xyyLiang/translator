    public func getScript(): EditScript<Char> {
        let script = EditScript<Char>()
        buildScript(0, left.size, 0, right.size, script)
        return script
    }