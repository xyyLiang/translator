    public OAuth1RequestToken(String token, String tokenSecret, boolean oauthCallbackConfirmed, String rawResponse) {
        super(token, tokenSecret, rawResponse);
        this.oauthCallbackConfirmed = oauthCallbackConfirmed;
    }