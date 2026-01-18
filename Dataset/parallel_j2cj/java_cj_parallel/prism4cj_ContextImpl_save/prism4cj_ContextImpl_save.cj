    public func save(origin: MyHashKey<Grammar>, clone: ?Grammar): Unit {
        cache.put(origin.hashCode(), clone)
    }