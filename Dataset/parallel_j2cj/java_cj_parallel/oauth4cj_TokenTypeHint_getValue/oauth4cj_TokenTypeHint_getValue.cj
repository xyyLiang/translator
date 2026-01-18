    public func getValue(): String {
        match (this) {
            case ACCESS_TOKEN_HINT => "access_token"
            case REFRESH_TOKEN_HINT => "refresh_token" 
        }
    }