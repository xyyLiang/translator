    public OAuthResponseException(Response rawResponse) throws IOException {
        super(rawResponse.getBody());
        this.response = rawResponse;
    }