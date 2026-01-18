    public func equals(object: Object): Bool {
        let objectAS: Option<OAuth1AccessToken> = object as OAuth1AccessToken
        match (objectAS) {
            case Some(token) =>
                if (!(token.getToken() == getToken())){
                    return false
                } else {
                    return (token.getTokenSecret() == getTokenSecret())
                }
            case None => return false
        }
    }