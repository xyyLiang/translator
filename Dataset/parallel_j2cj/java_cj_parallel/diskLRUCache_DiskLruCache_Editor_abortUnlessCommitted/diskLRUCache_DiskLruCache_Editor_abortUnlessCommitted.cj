    public func abortUnlessCommitted(): Unit {
        if (!committed) {
            try {
                abort()
            } catch (ignored: Exception) {
            }
        }
    }