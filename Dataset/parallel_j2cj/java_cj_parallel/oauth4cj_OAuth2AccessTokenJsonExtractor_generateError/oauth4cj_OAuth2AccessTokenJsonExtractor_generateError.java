    public void generateError(Response response) throws IOException {
        final String responseBody = response.getBody();
        final JsonNode responseBodyJson;
        try {
            responseBodyJson = OBJECT_MAPPER.readTree(responseBody);
        } catch (JsonProcessingException ex) {
            throw new OAuth2AccessTokenErrorResponse(null, null, null, response);
        }

        final JsonNode errorUriInString = responseBodyJson.get("error_uri");
        URI errorUri;
        try {
            errorUri = errorUriInString == null ? null : URI.create(errorUriInString.asText());
        } catch (IllegalArgumentException iae) {
            errorUri = null;
        }

        OAuth2Error errorCode;
        try {
            errorCode = OAuth2Error
                    .parseFrom(extractRequiredParameter(responseBodyJson, "error", responseBody).asText());
        } catch (IllegalArgumentException iaE) {
            //non oauth standard error code
            errorCode = null;
        }

        final JsonNode errorDescription = responseBodyJson.get("error_description");

        throw new OAuth2AccessTokenErrorResponse(errorCode, errorDescription == null ? null : errorDescription.asText(),
                errorUri, response);
    }