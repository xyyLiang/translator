    public func extract(response: OAuth4cjResponse): OAuth2AccessToken {
        if (response.getCode() != 200) {
            throw OAuth4cjException("Response code is not 200 but '${response.getCode()}'")
        }
        let body: String = response.getBody()
        Preconditions.checkEmptyString(body, "Response body is incorrect. Can't extract a token from an empty string")

        let accessToken: String = extractParameter(body, ACCESS_TOKEN_REGEX_PATTERN, true)
        let tokenType: String = extractParameter(body, TOKEN_TYPE_REGEX_PATTERN, false)
        let expiresInString: String = extractParameter(body, EXPIRES_IN_REGEX_PATTERN, false)
        var expiresIn: Int32 = 0
        try {
            if (!expiresInString.isEmpty()) {
                expiresIn = Int32.parse(expiresInString)
            }
        } catch (nfe: Exception) {
            expiresIn = 0
        }
        let refreshToken: String = extractParameter(body, REFRESH_TOKEN_REGEX_PATTERN, false)
        let scope: String = extractParameter(body, SCOPE_REGEX_PATTERN, false)

        return OAuth2AccessToken(accessToken, tokenType, expiresIn, refreshToken, scope, body)
    }