    public func close(): Unit {
        isClosed = true
        for (fse in ins) {
            Util.closeQuietly(fse)
        }
    }