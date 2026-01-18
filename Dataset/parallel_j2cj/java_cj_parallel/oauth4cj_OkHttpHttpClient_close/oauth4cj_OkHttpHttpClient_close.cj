    public func close(): Unit {
        if (closed) {
            return
        }
        client.getDispatcher().cancelAll()
        match (client.getConnectionPool()) {
            case Some(v) => v.evictAll()
            case None => ()
        }
        let cache: Option<Cache> = client.getCache()
        match (cache) {
            case Some(v) => v.close()
            case None => ()
        }
        closed = true
    }