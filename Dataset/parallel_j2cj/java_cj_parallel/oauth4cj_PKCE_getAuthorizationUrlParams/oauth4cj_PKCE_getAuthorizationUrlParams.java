    public Map<String, String> getAuthorizationUrlParams() {
        final Map<String, String> params = new HashMap<>();
        params.put(PKCE_CODE_CHALLENGE_PARAM, codeChallenge);
        params.put(PKCE_CODE_CHALLENGE_METHOD_PARAM, codeChallengeMethod.name());
        return params;
    }