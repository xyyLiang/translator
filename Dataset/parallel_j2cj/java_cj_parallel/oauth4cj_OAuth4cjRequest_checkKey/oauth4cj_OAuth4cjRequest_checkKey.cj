    private func checkKey(key: String): String {
        if (key.startsWith(OAUTH_PREFIX) || (key == OAuthConstants.SCOPE) || (key == OAuthConstants.REALM)) {
            return key
        } else {
            let err: String = "OAuth parameters must either be " + OAuthConstants.SCOPE + ", " +
                                OAuthConstants.REALM + " or start with " + OAUTH_PREFIX
            throw OAuth4cjParametersMissingException(err)
        }
    }