    public DeviceAuthorization extract(Response response) throws IOException {
        if (response.getCode() != 200) {
            generateError(response);
        }
        return createDeviceAuthorization(response.getBody());
    }