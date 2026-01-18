    public func getRequestTokenAsync(callback: Option<OAuthAsyncRequestCallback>): Future<OAuth1RequestToken> {
        if (isDebug()) {
            log("async obtaining request token from ${api.getRequestTokenEndpoint()}")
        }
        let request: OAuth4cjRequest = prepareRequestTokenRequest()
        let defaultConverter: DefaultRequestTokenConverter = DefaultRequestTokenConverter(api)
        let res: Future<Any> = execute(request, callback, Some(defaultConverter))
        let newFuture: Future<OAuth1RequestToken> = spawn {
            let result = res.get()
            let token: Option<OAuth1RequestToken> = result as OAuth1RequestToken
            match(token) {
                case Some(v) => return v
                case None =>
                    let err: String = "Exception in parsing OAuth1RequestToken," + 
                        "response is: ${defaultConverter.responseString}"
                    let ex: Exception = (result as Exception) ?? OAuth4cjException(err)
                    throw OAuth4cjException(ex.message)
            }
        }
        return newFuture
    }