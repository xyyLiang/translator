    public func getRequestToken(): OAuth1RequestToken {
        if (isDebug()) {
            log("obtaining request token from ${api.getRequestTokenEndpoint()}")
        }
        let request: OAuth4cjRequest  = prepareRequestTokenRequest()
        log("sending request...")
        try {
            let response: OAuth4cjResponse = execute(request)
            if (isDebug()) {
                let body: String = response.getBody()
                log("response status code: ${response.getCode()}")
                log("response body: ${body}")
            }
            return api.getRequestTokenExtractor().extract(response)
        } catch (ex: Exception) {
            throw OAuth4cjException("An exception occurred during the request process: " + ex.message)
        }
    }