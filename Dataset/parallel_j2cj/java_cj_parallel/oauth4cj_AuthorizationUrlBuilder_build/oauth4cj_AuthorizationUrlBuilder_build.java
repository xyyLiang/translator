    public String build() {
        final Map<String, String> params;
        if (pkce == null) {
            params = additionalParams;
        } else {
            params = additionalParams == null ? new HashMap<String, String>() : new HashMap<>(additionalParams);
            params.putAll(pkce.getAuthorizationUrlParams());
        }
        return oauth20Service.getApi().getAuthorizationUrl(oauth20Service.getResponseType(), oauth20Service.getApiKey(),
                oauth20Service.getCallback(), scope == null ? oauth20Service.getDefaultScope() : scope, state, params);
    }