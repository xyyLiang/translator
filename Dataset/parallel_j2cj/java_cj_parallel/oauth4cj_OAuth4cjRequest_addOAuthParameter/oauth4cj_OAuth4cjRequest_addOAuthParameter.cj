    public func addOAuthParameter(key: String, value: String): Unit {
        this.oauthParameters.put(checkKey(key), value);
    }