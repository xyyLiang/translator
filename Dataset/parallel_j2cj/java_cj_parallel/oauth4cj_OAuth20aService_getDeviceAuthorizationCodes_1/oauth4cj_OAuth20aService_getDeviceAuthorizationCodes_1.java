    public DeviceAuthorization getDeviceAuthorizationCodes(String scope)
            throws InterruptedException, ExecutionException, IOException {
        final OAuthRequest request = createDeviceAuthorizationCodesRequest(scope);

        try (Response response = execute(request)) {
            if (isDebug()) {
                log("got DeviceAuthorizationCodes response");
                log("response status code: %s", response.getCode());
                log("response body: %s", response.getBody());
            }
            return api.getDeviceAuthorizationExtractor().extract(response);
        }
    }