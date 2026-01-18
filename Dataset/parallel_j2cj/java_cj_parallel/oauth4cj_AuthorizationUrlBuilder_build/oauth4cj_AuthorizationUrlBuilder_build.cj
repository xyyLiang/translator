    public func build(): String {
        build(oauth20Service, state, additionalParams, pkce, scope)
    }
func build(oauth20Service: OAuth20Service, state: Option<String>,
                additionalParams: HashMap<String, String>, pkce: Option<PKCE>, scope: Option<String>): String {
    var params: HashMap<String, String>
    match (pkce) {
        case Some(x) =>
            params = HashMap<String, String>(additionalParams)
            params.putAll(x.getAuthorizationUrlParams())
        case _ => params = additionalParams
    }

    let scopeBuild: Option<String> = scope ?? oauth20Service.getDefaultScope()

    return oauth20Service.getApi().getAuthorizationUrl(oauth20Service.getResponseType(), oauth20Service.getApiKey(),
            oauth20Service.getCallback(), scopeBuild, state, params)
}