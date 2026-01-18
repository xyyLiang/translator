    public String getAuthorizationUrl(Map<String, String> additionalParams) {
        return createAuthorizationUrlBuilder()
                .additionalParams(additionalParams)
                .build();
    }