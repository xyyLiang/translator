    public func build(): String {
        let scopeBuilder: StringBuilder = StringBuilder()
        var isFirst: Bool = true
        for (scope in scopes) {
            if (isFirst) {
                isFirst = false
                scopeBuilder.append(scope)
                continue
            }
            scopeBuilder.append(' ')
            scopeBuilder.append(scope)
        }
        var scopeString = scopeBuilder.toString()
        Preconditions.checkEmptyString(scopeString, "Cannot get String from a empty ScopeBuilder.")
        return scopeString
    }