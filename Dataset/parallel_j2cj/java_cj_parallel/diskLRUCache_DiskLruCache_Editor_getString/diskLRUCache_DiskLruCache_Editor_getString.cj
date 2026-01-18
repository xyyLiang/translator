    public func getString(index: Int64): String {
        let inse: Option<InputStream> = newInputStream(index)
        match (inse) {
            case Some(K) => 
                return DiskLruCache.inputStreamToString(K)
            case None => 
                return ""
        }
    }