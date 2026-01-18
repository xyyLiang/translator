    protected func createToken(accessToken: String, tokenType: String, expiresIn: Int32,
            refreshToken: String, scope: String, rawResponse: String): OAuth2AccessToken {
        return OAuth2AccessToken(accessToken, tokenType, expiresIn, refreshToken, scope, rawResponse)
    }