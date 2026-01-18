    public func generatePKCE(randomBytes: Array<UInt8>): PKCE {
        let codeVerifier: String = Base64Utils.encodeUrlWithoutPadding(randomBytes)
        let pkce: PKCE = PKCE()
        pkce.setCodeVerifier(codeVerifier)
        try {
            pkce.setCodeChallenge(pkce.getCodeChallengeMethod().transform2CodeChallenge(codeVerifier))
        } catch (nsaE: Exception) {
            pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
            try {
                pkce.setCodeChallenge(PKCECodeChallengeMethod.PLAIN.transform2CodeChallenge(codeVerifier))
            } catch (unrealE: Exception) {
                throw OAuth4cjException("It's just cannot be" + unrealE.message)
            }
        }
        return pkce
    }