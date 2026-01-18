    public func commit(): Unit {
        if (hasErrors) {
            disk.completeEdit(this, false)
            disk.remove(entry.key)
        } else {
            disk.completeEdit(this, true)
        }
        committed = true
    }