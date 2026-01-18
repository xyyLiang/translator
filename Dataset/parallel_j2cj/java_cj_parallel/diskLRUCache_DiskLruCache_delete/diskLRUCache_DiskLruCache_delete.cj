    public func delete(): Unit {
        close()
        Util.deleteContents(directory)
    }
