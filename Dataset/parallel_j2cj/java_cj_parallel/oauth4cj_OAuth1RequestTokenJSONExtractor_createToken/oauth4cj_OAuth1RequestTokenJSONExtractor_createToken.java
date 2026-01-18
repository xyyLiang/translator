    @Override
    protected OAuth1RequestToken createToken(String token, String secret, String response) {
        return new OAuth1RequestToken(token, secret, response);
    }