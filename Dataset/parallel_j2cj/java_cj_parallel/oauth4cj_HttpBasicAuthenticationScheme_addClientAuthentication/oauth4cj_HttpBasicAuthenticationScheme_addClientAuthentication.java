    @Override
    public void addClientAuthentication(OAuthRequest request, String apiKey, String apiSecret) {
        if (apiKey != null && apiSecret != null) {
            request.addHeader(OAuthConstants.HEADER, OAuthConstants.BASIC + ' '
                    + Base64.encode(String.format("%s:%s", apiKey, apiSecret).getBytes(Charset.forName("UTF-8"))));
        }
    }