    protected func sendAccessTokenRequestAsync(request: OAuth4cjRequest,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        if (isDebug()) {
            log("send request for access token asynchronously to ${request.getCompleteUrl()}")
        }

        let rc: ResponseConverterOAuth2AccessToken = ResponseConverterOAuth2AccessToken(api)
        let res: Future<Any> = execute(request, callback, Some(rc))

        let nowFuture: Future<OAuth2AccessToken> = spawn {
            let result = res.get()
            let token: Option<OAuth2AccessToken> = result as OAuth2AccessToken
            match(token) {
                case Some(v) => return v
                case None =>
                    let err: String = "Exception in parsing OAuth2AccessToken, response is: ${rc.responseString}"
                    let ex: Exception = (result as Exception) ?? OAuth4cjException(err)
                    throw OAuth4cjException(ex.message)
            }
        }
        return nowFuture
    }