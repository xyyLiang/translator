    public func isPermitBody(): Bool {
        match (this) {
            case GET => false
            case POST => true
            case PUT => true
            case DELETE => true
            case HEAD => false
            case OPTIONS => false
            case TRACE => false
            case PATCH => true
        }
    }