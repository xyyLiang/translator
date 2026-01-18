    protected func createToken(token: String, secret: String, response: String): OAuth1AccessToken {
        return OAuth1AccessToken(token, secret, response)
    }