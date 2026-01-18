    public func addHeader(key: String, value: String): Unit {
        let keyUpper: String = key.toAsciiUpper()
        if (this.headersKey.contains(keyUpper)) {
            this.headers.put(this.headersKey[keyUpper], value)
        } else {
            this.headers.put(key, value)
            this.headersKey.put(keyUpper, key)
        }
    }