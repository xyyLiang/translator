    public func edit(): Option<Editor> {
        return disk.edit(key, sequenceNumber)
    }