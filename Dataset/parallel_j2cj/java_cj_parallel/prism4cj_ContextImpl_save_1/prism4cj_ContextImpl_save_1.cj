    public func save(origin: MyHashKey<Token>, clone: ?Token): Unit {
        cache.put(origin.hashCode(), clone)
    }