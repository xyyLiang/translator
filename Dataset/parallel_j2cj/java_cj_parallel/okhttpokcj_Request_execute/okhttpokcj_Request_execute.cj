    public func execute(callback: Callback): Unit {
        this.callback = callback
        var call: Call = adapt()
        call.execute(callback)
    }