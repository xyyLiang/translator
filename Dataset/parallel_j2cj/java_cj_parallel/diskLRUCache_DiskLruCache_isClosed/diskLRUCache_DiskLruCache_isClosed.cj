    public func isClosed(): Bool {
        synchronized (lock) {
            match (journalWriter) {
                case Some(_) => return false
                case None => return true
            }
        }
    }