    public func getErrorString(): String {
        match (this) {
            case INVALID_REQUEST => "invalid_request"
            case UNAUTHORIZED_CLIENT => "unauthorized_client"
            case ACCESS_DENIED => "access_denied"
            case UNSUPPORTED_RESPONSE_TYPE => "unsupported_response_type"
            case INVALID_SCOPE => "invalid_scope"
            case SERVER_ERROR => "server_error"
            case TEMPORARILY_UNAVAILABLE => "temporarily_unavailable"
            case INVALID_CLIENT => "invalid_client"
            case INVALID_GRANT => "invalid_grant"
            case UNSUPPORTED_GRANT_TYPE => "unsupported_grant_type"
            case INVALID_TOKEN => "invalid_token"
            case INSUFFICIENT_SCOPE => "insufficient_scope"
            case UNSUPPORTED_TOKEN_TYPE => "unsupported_token_type"
            case AUTHORIZATION_PENDING => "authorization_pending"
            case SLOW_DOWN => "slow_down"
            case EXPIRED_TOKEN => "expired_token"
        }
    }