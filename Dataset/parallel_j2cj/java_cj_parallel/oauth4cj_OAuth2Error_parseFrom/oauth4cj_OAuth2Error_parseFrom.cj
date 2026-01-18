    public static func parseFrom(errorString: String): OAuth2Error {
        match (errorString) {
            case "invalid_request" => INVALID_REQUEST
            case "unauthorized_client" => UNAUTHORIZED_CLIENT
            case "access_denied" => ACCESS_DENIED
            case "unsupported_response_type" => UNSUPPORTED_RESPONSE_TYPE
            case "invalid_scope" => INVALID_SCOPE
            case "server_error" => SERVER_ERROR
            case "temporarily_unavailable" => TEMPORARILY_UNAVAILABLE
            case "invalid_client" => INVALID_CLIENT
            case "invalid_grant" => INVALID_GRANT
            case "unsupported_grant_type" => UNSUPPORTED_GRANT_TYPE
            case "invalid_token" => INVALID_TOKEN
            case "insufficient_scope" => INSUFFICIENT_SCOPE
            case "unsupported_token_type" => UNSUPPORTED_TOKEN_TYPE
            case "authorization_pending" => AUTHORIZATION_PENDING
            case "slow_down" => SLOW_DOWN
            case "expired_token" => EXPIRED_TOKEN
            case _ => throw IllegalArgumentException("there is no knowlege about ${errorString} Error")
        }
    }