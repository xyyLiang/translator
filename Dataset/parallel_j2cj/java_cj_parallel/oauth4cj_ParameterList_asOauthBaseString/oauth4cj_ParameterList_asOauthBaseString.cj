    public func asOauthBaseString(): String {
        return OAuthEncoder.encode(asFormUrlEncodedString())
    }