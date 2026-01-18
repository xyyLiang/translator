    @Override
    public OAuth2AccessToken extract(Response response) throws IOException {
        if (response.getCode() != 200) {
            throw new OAuthException("Response code is not 200 but '" + response.getCode() + '\'');
        }
        final String body = response.getBody();
        Preconditions.checkEmptyString(body,
                "Response body is incorrect. Can't extract a token from an empty string");

        final String accessToken = extractParameter(body, ACCESS_TOKEN_REGEX_PATTERN, true);
        final String tokenType = extractParameter(body, TOKEN_TYPE_REGEX_PATTERN, false);
        final String expiresInString = extractParameter(body, EXPIRES_IN_REGEX_PATTERN, false);
        Integer expiresIn;
        try {
            expiresIn = expiresInString == null ? null : Integer.valueOf(expiresInString);
        } catch (NumberFormatException nfe) {
            expiresIn = null;
        }
        final String refreshToken = extractParameter(body, REFRESH_TOKEN_REGEX_PATTERN, false);
        final String scope = extractParameter(body, SCOPE_REGEX_PATTERN, false);

        return new OAuth2AccessToken(accessToken, tokenType, expiresIn, refreshToken, scope, body);
    }