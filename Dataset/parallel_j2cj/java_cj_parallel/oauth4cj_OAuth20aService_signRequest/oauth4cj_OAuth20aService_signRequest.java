    public void signRequest(String accessToken, OAuthRequest request) {
        api.getBearerSignature().signRequest(accessToken, request);
    }