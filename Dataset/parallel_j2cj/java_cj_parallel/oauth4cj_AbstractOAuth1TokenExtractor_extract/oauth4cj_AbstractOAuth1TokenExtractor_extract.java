    @Override
    public T extract(Response response) throws IOException {
        final String body = response.getBody();
        Preconditions.checkEmptyString(body,
                "Response body is incorrect. Can't extract a token from an empty string");
        final String token = extract(body, OAUTH_TOKEN_REGEXP_PATTERN);
        final String secret = extract(body, OAUTH_TOKEN_SECRET_REGEXP_PATTERN);
        return createToken(token, secret, body);
    }