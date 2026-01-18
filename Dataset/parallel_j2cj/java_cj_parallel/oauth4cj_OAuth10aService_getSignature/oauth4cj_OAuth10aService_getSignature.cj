    private func getSignature(request: OAuth4cjRequest, tokenSecret: String): String {
        log("generating signature...")
        let baseString: String = api.getBaseStringExtractor().extract(request)
        let signature: String = api.getSignatureService().getSignature(baseString, getApiSecret(), tokenSecret)

        if (isDebug()) {
            log("base string is: ${baseString}")
            log("signature is: ${signature}")
        }
        return signature
    }