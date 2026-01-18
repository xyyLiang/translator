    public func extractAuthorization(redirectLocation: String): OAuth2Authorization {
        let authorization: OAuth2Authorization = OAuth2Authorization()
        var end: Int64 = redirectLocation.indexOf("#") ?? -1
        if (end == -1) {
            end = redirectLocation.size
        }
        let start: Int64 = (redirectLocation.indexOf("?") ?? -1) + 1
        let subStr: String = redirectLocation[start..end]
        let params: Array<String> = subStr.split("&")
        for (param in params) {
            let keyValue: Array<String> = param.split("=")
            if (keyValue.size == 2) {
                try {
                    if (keyValue[0] == "code") {
                        authorization.setCode(URLEncoder.decode(keyValue[1], "UTF-8"))
                    } else if (keyValue[0] == "state") {
                        authorization.setState(URLEncoder.decode(keyValue[1], "UTF-8"))
                    }
                } catch (ueE: Exception) {
                    throw OAuth4cjException("unsupported decoding. " + ueE.message)
                }
            }
        }
        return authorization
    }
