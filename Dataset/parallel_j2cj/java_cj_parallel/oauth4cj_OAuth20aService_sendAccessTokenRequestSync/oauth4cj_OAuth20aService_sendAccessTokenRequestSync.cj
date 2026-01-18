    protected func sendAccessTokenRequestSync(request: OAuth4cjRequest): OAuth2AccessToken {
        if (isDebug()) {
            log("send request for access token synchronously to ${request.getCompleteUrl()}")
        }

        let response: OAuth4cjResponse = execute(request)
        if (isDebug()) {
            log("response status code: ${response.getCode()}")
            log("response body: ${response.getBody()}")
        }

        return api.getAccessTokenExtractor().extract(response)
    }