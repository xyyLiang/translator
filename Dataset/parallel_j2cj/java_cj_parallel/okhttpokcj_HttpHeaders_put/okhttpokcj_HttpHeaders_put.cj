    public func put(key: String, value: String) {
        if (!(key.isEmpty()) && !(value.isEmpty())) {
            headersMap.put(key, value)
        }
    }