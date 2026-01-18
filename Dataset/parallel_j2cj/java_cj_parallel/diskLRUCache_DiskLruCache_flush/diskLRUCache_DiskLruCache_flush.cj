    public func flush(): Unit {
        synchronized (lock) {
            checkNotClosed()
            trimToSize()
            journalWriter.getOrThrow().flush()
        }
    }