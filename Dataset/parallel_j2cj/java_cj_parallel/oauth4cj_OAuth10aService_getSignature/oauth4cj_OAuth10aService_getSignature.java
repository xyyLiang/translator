    private String getSignature(OAuthRequest request, String tokenSecret) {
        log("generating signature...");
        final String baseString = api.getBaseStringExtractor().extract(request);
        final String signature = api.getSignatureService().getSignature(baseString, getApiSecret(), tokenSecret);

        if (isDebug()) {
            log("base string is: %s", baseString);
            log("signature is: %s", signature);
        }
        return signature;
    }