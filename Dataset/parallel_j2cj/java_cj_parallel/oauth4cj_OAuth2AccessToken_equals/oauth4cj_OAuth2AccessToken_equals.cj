    public func equals(object: Object): Bool {
        let objectAS: Option<OAuth2AccessToken> = object as OAuth2AccessToken
        match (objectAS) {
            case Some(token) =>
                if (!(token.getAccessToken() == accessToken)){
                    return false
                } 
                if (!(token.getTokenType() == tokenType)){
                    return false
                } 
                if (!(token.getRefreshToken() == refreshToken)){
                    return false
                } 
                if (!(token.getScope() == scope)){
                    return false
                } 
                return token.getExpiresIn() == expiresIn
            case None => return false
        }
    }