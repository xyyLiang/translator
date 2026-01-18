    public OAuth2AccessToken(String accessToken, String tokenType, Integer expiresIn, String refreshToken, String scope,
            String rawResponse) {
        super(rawResponse);
        Preconditions.checkNotNull(accessToken, "access_token can't be null");
        this.accessToken = accessToken;
        this.tokenType = tokenType;
        this.expiresIn = expiresIn;
        this.refreshToken = refreshToken;
        this.scope = scope;
    }