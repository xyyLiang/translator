    public func withScope(scope: String): ScopeBuilder {
        scopes.put(scope)
        return this
    }