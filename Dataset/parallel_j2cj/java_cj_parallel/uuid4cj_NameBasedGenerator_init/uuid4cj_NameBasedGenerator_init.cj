    public init(namespace: ?UUID, digester: ?MessageDigest, types: ?UUIDType) {
        _namespace = namespace
        // And default digester SHA-1
        match (digester) {
            case None => 
                _digester = MessageDigest(DigestType.SHA1)
            case Some(_) =>
                _digester = digester
        }
        match (types) {
            case None => 
                let typeStr: String = _digester.getOrThrow().getAlgorithm().toString()
                if (typeStr.startsWith("MD5")) {
                    _types = UUIDType.NAME_BASED_MD5
                } else if (typeStr.startsWith("SHA")) {
                    _types = UUIDType.NAME_BASED_SHA1
                } else {
                    // Default to SHA-1, but log a warning
                    _types = UUIDType.NAME_BASED_SHA1
                    logger.warn("Could not determine type of Digester from '%s' assuming 'SHA-1' type")
                }
            case Some(_) =>
                _types = types
        }
    }