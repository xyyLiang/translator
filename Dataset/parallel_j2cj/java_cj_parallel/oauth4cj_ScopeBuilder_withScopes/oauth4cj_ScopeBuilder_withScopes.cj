    public func withScopes(scopes: Array<String>): ScopeBuilder {
        this.scopes.putAll(scopes)
        return this
    }