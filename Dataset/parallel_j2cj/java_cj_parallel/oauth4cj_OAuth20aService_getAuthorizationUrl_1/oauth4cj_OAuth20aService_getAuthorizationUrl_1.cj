    public func getAuthorizationUrl(state: Option<String>): String {
        return build(this, state, HashMap<String, String>(), None, None)
    }