    public String getAuthorizationUrl(PKCE pkce) {
        return createAuthorizationUrlBuilder()
                .pkce(pkce)
                .build();
    }