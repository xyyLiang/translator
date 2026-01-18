    public OAuth2AccessToken refreshAccessToken(String refreshToken)
            throws IOException, InterruptedException, ExecutionException {
        return refreshAccessToken(refreshToken, (String) null);
    }