    public func getAuthorizationUrlParams(): HashMap<String, String> {
        let params: HashMap<String, String> = HashMap<String, String>()
        params.put(PKCE_CODE_CHALLENGE_PARAM, codeChallenge)
        params.put(PKCE_CODE_CHALLENGE_METHOD_PARAM, codeChallengeMethod.toString())
        return params
    }