    public OAuth2AccessToken pollAccessTokenDeviceAuthorizationGrant(DeviceAuthorization deviceAuthorization)
            throws InterruptedException, ExecutionException, IOException {
        long intervalMillis = deviceAuthorization.getIntervalSeconds() * 1000;
        while (true) {
            try {
                return getAccessTokenDeviceAuthorizationGrant(deviceAuthorization);
            } catch (OAuth2AccessTokenErrorResponse e) {
                if (e.getError() != OAuth2Error.AUTHORIZATION_PENDING) {
                    if (e.getError() == OAuth2Error.SLOW_DOWN) {
                        intervalMillis += 5000;
                    } else {
                        throw e;
                    }
                }
            }
            Thread.sleep(intervalMillis);
        }
    }