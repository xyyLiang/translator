    @Override
    public void addClientAuthentication(OAuthRequest request, String apiKey, String apiSecret) {
        request.addParameter(OAuthConstants.CLIENT_ID, apiKey);
        if (apiSecret != null) {
            request.addParameter(OAuthConstants.CLIENT_SECRET, apiSecret);
        }
    }