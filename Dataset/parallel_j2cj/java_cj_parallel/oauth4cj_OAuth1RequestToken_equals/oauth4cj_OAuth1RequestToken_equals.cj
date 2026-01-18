    public func equals(object: Object): Bool {
        let objectAS: Option<OAuth1RequestToken> = object as OAuth1RequestToken
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