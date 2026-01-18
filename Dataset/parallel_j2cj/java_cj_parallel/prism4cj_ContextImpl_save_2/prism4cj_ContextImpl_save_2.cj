    public func save(origin: MyHashKey<Pattern>, clone: ?Pattern): Unit {
        cache.put(origin.hashCode(), clone)
    }