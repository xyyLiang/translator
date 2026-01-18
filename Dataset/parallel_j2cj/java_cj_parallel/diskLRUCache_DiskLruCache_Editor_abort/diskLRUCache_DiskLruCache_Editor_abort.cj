    public func abort(): Unit {
        disk.completeEdit(this, false)
    }