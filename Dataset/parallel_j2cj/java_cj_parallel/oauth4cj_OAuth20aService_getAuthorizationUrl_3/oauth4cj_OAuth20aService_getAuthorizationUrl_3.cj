    public func getAuthorizationUrl(pkce: Option<PKCE>): String {
        return build(this, None, HashMap<String, String>(), pkce, None)
    }
