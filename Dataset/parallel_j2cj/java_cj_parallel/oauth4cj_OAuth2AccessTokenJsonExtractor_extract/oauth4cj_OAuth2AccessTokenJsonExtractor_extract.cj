    public func extract(response: OAuth4cjResponse): OAuth2AccessToken {
        let body: String = response.getBody()
        Preconditions.checkEmptyString(body, "Response body is incorrect. Can't extract a token from an empty string")

        if (response.getCode() != 200) {
            generateError(response)
        }
        return createToken(body)
    }