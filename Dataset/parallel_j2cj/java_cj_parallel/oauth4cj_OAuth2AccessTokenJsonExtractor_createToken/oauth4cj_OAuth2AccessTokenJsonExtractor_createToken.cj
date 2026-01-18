    private func createToken(rawResponse: String): OAuth2AccessToken {
        let response: JsonObject = JsonValue.fromStr(rawResponse).asObject()

        var expiresInNode: Int32 = 0
        if (response.containsKey("expires_in")) {
            expiresInNode = asIntOfJsonValue(response.get("expires_in").getOrThrow(), 0)
        }

        var refreshToken: String = ""
        if (response.containsKey(OAuthConstants.REFRESH_TOKEN)) {
            refreshToken = asTextOfJsonValue(response.get(OAuthConstants.REFRESH_TOKEN).getOrThrow())
        }

        var scope: String = ""
        if (response.containsKey(OAuthConstants.SCOPE)) {
            scope = asTextOfJsonValue(response.get(OAuthConstants.SCOPE).getOrThrow())
        }

        var tokenType: String = ""
        if (response.containsKey("token_type")) {
            tokenType = asTextOfJsonValue(response.get("token_type").getOrThrow())
        }

        return createToken(
                asTextOfJsonValue(extractRequiredParameter(response, OAuthConstants.ACCESS_TOKEN, rawResponse)),
                tokenType, expiresInNode, refreshToken, scope, rawResponse)
    }