    @Override
    public Response execute(String userAgent, Map<String, String> headers, Verb httpVerb, String completeUrl,
            MultipartPayload bodyContents) throws InterruptedException, ExecutionException, IOException {

        throw new UnsupportedOperationException("OKHttpClient does not support Multipart payload for the moment");
    }