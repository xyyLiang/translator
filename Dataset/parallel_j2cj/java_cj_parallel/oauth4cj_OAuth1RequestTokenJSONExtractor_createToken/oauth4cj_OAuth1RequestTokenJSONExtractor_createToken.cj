    protected func createToken(token: String, secret: String, response: String): OAuth1RequestToken {
        return OAuth1RequestToken(token, secret, response)
    }