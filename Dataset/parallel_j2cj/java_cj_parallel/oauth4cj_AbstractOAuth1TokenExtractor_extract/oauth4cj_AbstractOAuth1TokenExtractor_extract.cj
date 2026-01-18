    public func extract(response: OAuth4cjResponse): T {
        let body: String = response.getBody()
        Preconditions.checkEmptyString(body, "Response body is incorrect. Can't extract a token from an empty string")
        let token: String = extract(body, OAUTH_TOKEN_REGEXP_PATTERN)
        let secret: String = extract(body, OAUTH_TOKEN_SECRET_REGEXP_PATTERN)
        return createToken(token, secret, body)
    }