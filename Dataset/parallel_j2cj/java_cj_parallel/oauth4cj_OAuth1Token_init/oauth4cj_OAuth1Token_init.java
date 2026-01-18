    public OAuth1Token(String token, String tokenSecret, String rawResponse) {
        super(rawResponse);
        Preconditions.checkNotNull(token, "oauth_token can't be null");
        Preconditions.checkNotNull(tokenSecret, "oauth_token_secret can't be null");
        this.token = token;
        this.tokenSecret = tokenSecret;
    }