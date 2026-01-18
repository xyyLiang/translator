    public func withScopes(scopes: Collection<String>): ScopeBuilder {
        this.scopes.putAll(scopes)
        return this
    }