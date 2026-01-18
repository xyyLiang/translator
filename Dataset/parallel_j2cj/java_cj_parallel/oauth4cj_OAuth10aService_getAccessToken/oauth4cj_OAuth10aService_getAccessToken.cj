    public func getAccessToken(requestToken: OAuth1RequestToken, oauthVerifier: String): OAuth1AccessToken {
        if (isDebug()) {
            log("obtaining access token from ${api.getAccessTokenEndpoint()}")
        }
        let request: OAuth4cjRequest  = prepareAccessTokenRequest(requestToken, oauthVerifier)
        try {
            let response: OAuth4cjResponse = execute(request)
            return api.getAccessTokenExtractor().extract(response)
        } catch (ex: Exception) {
            throw OAuth4cjException("An exception occurred during the request process: " + ex.message)
        }
    }