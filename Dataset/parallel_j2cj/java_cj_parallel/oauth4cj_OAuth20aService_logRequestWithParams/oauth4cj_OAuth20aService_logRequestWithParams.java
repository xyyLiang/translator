    protected void logRequestWithParams(String requestDescription, OAuthRequest request) {
        if (isDebug()) {
            log("created " + requestDescription + " request with body params [%s], query string params [%s]",
                    request.getBodyParams().asFormUrlEncodedString(),
                    request.getQueryStringParams().asFormUrlEncodedString());
        }
    }