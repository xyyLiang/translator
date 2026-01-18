    public func generateError(response: OAuth4cjResponse): Unit {
        let responseBody: String = response.getBody()
        var responseBodyJson: JsonObject = JsonObject()
        let emptyErrorUri: URL = URL.parse("")
        try {
            responseBodyJson = JsonValue.fromStr(responseBody).asObject()
        } catch (ex: Exception) {
            throw OAuth2AccessTokenErrorResponseException(None, "", emptyErrorUri, response)
        }

        var errorUriInString: String = ""
        if (responseBodyJson.containsKey("error_uri")) {
            errorUriInString = asTextOfJsonValue(responseBodyJson.get("error_uri").getOrThrow())
        }

        var errorUri: URL = emptyErrorUri
        try {
            errorUri = URL.parse(errorUriInString)
        } catch (iae: IllegalArgumentException) {
            errorUri = emptyErrorUri
        }

        var errorCode: Option<OAuth2Error> = None
        try {
            errorCode = OAuth2Error.parseFrom(
                        asTextOfJsonValue(extractRequiredParameter(responseBodyJson, "error", responseBody)))
        } catch (iaE: IllegalArgumentException) {
            errorCode = None
        }

        var errorDescription: String = ""
        if (responseBodyJson.containsKey("error_description")) {
            errorDescription = asTextOfJsonValue(responseBodyJson.get("error_description").getOrThrow())
        }

        throw OAuth2AccessTokenErrorResponseException(errorCode, errorDescription, errorUri, response)
    }