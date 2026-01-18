    public func asUrlEncodedPair(): String {
        return OAuthEncoder.encode(key) + "=" + OAuthEncoder.encode(value)
    }