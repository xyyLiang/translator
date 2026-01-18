    public func isRequiresBody(): Bool {
        match (this) {
            case GET => false
            case POST => true
            case PUT => true
            case DELETE => false
            case HEAD => false
            case OPTIONS => false
            case TRACE => false
            case PATCH => true
        }
    }