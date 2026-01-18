    public Response execute(OAuthRequest request) throws InterruptedException, ExecutionException, IOException {
        final File filePayload = request.getFilePayload();
        if (filePayload != null) {
            return httpClient.execute(userAgent, request.getHeaders(), request.getVerb(), request.getCompleteUrl(),
                    filePayload);
        } else if (request.getStringPayload() != null) {
            return httpClient.execute(userAgent, request.getHeaders(), request.getVerb(), request.getCompleteUrl(),
                    request.getStringPayload());
        } else if (request.getMultipartPayload() != null) {
            return httpClient.execute(userAgent, request.getHeaders(), request.getVerb(), request.getCompleteUrl(),
                    request.getMultipartPayload());
        } else {
            return httpClient.execute(userAgent, request.getHeaders(), request.getVerb(), request.getCompleteUrl(),
                    request.getByteArrayPayload());
        }
    }