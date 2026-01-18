public func close(): Unit{
        match (journalWriter) {
            case None =>
                return
            case Some(_) =>
                ()
        }

        for (entry in lruEntries.values()) {
            match (entry.currentEditor) {
                case None =>
                    ()
                case Some(s) =>
                    s.abort()
            }
        }
        trimToSize()
        journalWriter.getOrThrow().close()
        journalWriter = None
  
    }