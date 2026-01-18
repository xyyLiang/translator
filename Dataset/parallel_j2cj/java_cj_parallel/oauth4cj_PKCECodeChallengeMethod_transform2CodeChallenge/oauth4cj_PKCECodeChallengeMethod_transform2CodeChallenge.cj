    public func transform2CodeChallenge(codeVerifier: String): String {
        match(this) {
            case S256 =>
                let SHA256Instance: SHA256 = SHA256()
                let md: Array<Byte> = digest(SHA256Instance, codeVerifier)
                return Base64Utils.encodeUrlWithoutPadding(md)
            case PLAIN => return codeVerifier
        }
    }