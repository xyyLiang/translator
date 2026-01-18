    public func getAccessTokenAsync(requestToken: OAuth1RequestToken, oauthVerifier: String,
        callback: Option<OAuthAsyncRequestCallback>): Future<OAuth1AccessToken> {
        if (isDebug()) {
            log("async obtaining access token from ${api.getAccessTokenEndpoint()}")
        }
        let request: OAuth4cjRequest = prepareAccessTokenRequest(requestToken, oauthVerifier)
        let defaultConverter: DefaultAccessTokenConverter = DefaultAccessTokenConverter(api)
        let res: Future<Any> = execute(request, callback, Some(defaultConverter))

        let newFuture: Future<OAuth1AccessToken> = spawn {
            let result = res.get()
            let token: Option<OAuth1AccessToken> = result as OAuth1AccessToken
            match(token) {
                case Some(v) => return v
                case None =>
                    let err: String = "Exception in parsing OAuth1AccessToken," + 
                        "response is: ${defaultConverter.responseString}"
                    let ex: Exception = (result as Exception) ?? OAuth4cjException(err)
                    throw OAuth4cjException(ex.message)
            }
        }
        return newFuture
    }