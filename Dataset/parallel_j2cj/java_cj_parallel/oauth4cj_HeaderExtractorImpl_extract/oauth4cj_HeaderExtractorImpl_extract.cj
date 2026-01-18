    public func extract(request: OAuth4cjRequest): String {
        checkPreconditions(request)
        let parameters: HashMap<String, String> = request.getOauthParameters()

        let header: StringBuilder = StringBuilder(PREAMBLE)

        for ((k, v) in parameters) {
            if (header.size > PREAMBLE.size) {
                header.append(PARAM_SEPARATOR)
            }
            header.append(k)
            header.append("=\"")
            header.append(OAuthEncoder.encode(v))
            header.append('"')
        }

        if (!request.getRealm().isEmpty()) {
            header.append(PARAM_SEPARATOR)
            header.append(OAuthConstants.REALM)
            header.append("=\"")
            header.append(request.getRealm())
            header.append('"')
        }
        return header.toString()
    }
