    @Override
    public T extract(Response response) throws IOException {
        final String rawBody = response.getBody();
        Preconditions.checkEmptyString(rawBody,
                "Response body is incorrect. Can't extract a token from an empty string");

        final JsonNode body = OBJECT_MAPPER.readTree(rawBody);

        final JsonNode token = body.get(OAuthConstants.TOKEN);
        final JsonNode secret = body.get(OAuthConstants.TOKEN_SECRET);

        if (token == null || secret == null) {
            throw new OAuthException("Response body is incorrect. Can't extract token and secret from this: '"
                    + rawBody + '\'', null);
        }

        return createToken(token.asText(), secret.asText(), rawBody);
    }
