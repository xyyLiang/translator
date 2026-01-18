    public Future<DeviceAuthorization> getDeviceAuthorizationCodes(String scope,
            OAuthAsyncRequestCallback<DeviceAuthorization> callback) {
        final OAuthRequest request = createDeviceAuthorizationCodesRequest(scope);

        return execute(request, callback, new OAuthRequest.ResponseConverter<DeviceAuthorization>() {
            @Override
            public DeviceAuthorization convert(Response response) throws IOException {
                final DeviceAuthorization deviceAuthorization = api.getDeviceAuthorizationExtractor().extract(response);
                response.close();
                return deviceAuthorization;
            }
        });
    }