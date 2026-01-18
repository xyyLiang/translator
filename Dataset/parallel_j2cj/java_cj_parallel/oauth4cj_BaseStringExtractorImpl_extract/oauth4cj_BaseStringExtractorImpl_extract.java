    @Override
    public String extract(OAuthRequest request) {
        checkPreconditions(request);
        final String verb = OAuthEncoder.encode(getVerb(request));
        final String url = OAuthEncoder.encode(getUrl(request));
        final String params = getSortedAndEncodedParams(request);
        return String.format(AMPERSAND_SEPARATED_STRING, verb, url, params);
    }