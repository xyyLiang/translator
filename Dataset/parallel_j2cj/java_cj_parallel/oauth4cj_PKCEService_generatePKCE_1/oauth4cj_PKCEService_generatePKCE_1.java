    public PKCE generatePKCE(byte[] randomBytes) {
        final String codeVerifier = Base64.encodeUrlWithoutPadding(randomBytes);

        final PKCE pkce = new PKCE();
        pkce.setCodeVerifier(codeVerifier);
        try {
            pkce.setCodeChallenge(pkce.getCodeChallengeMethod().transform2CodeChallenge(codeVerifier));
        } catch (NoSuchAlgorithmException nsaE) {
            pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN);
            try {
                pkce.setCodeChallenge(PKCECodeChallengeMethod.PLAIN.transform2CodeChallenge(codeVerifier));
            } catch (NoSuchAlgorithmException unrealE) {
                throw new IllegalStateException("It's just cannot be", unrealE);
            }
        }
        return pkce;
    }