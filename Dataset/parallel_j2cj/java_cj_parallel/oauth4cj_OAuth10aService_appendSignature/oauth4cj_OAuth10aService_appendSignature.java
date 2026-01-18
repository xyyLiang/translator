    protected void appendSignature(OAuthRequest request) {
        final OAuth1SignatureType signatureType = api.getSignatureType();
        switch (signatureType) {
            case HEADER:
                log("using Http Header signature");

                final String oauthHeader = api.getHeaderExtractor().extract(request);
                request.addHeader(OAuthConstants.HEADER, oauthHeader);
                break;
            case QUERY_STRING:
                log("using Querystring signature");

                for (Map.Entry<String, String> oauthParameter : request.getOauthParameters().entrySet()) {
                    request.addQuerystringParameter(oauthParameter.getKey(), oauthParameter.getValue());
                }
                break;
            default:
                throw new IllegalStateException("Unknown new Signature Type '" + signatureType + "'.");
        }
    }