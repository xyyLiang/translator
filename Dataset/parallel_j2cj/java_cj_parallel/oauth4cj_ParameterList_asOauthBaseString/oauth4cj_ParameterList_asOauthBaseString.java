    public String asOauthBaseString() {
        return OAuthEncoder.encode(asFormUrlEncodedString());
    }