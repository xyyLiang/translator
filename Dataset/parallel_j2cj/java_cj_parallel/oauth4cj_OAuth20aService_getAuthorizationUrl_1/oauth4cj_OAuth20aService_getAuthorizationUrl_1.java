    public String getAuthorizationUrl(String state) {
        return createAuthorizationUrlBuilder()
                .state(state)
                .build();
    }