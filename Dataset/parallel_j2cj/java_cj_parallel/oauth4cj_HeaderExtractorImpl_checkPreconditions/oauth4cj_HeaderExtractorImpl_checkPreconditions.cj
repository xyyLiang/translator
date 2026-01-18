    private func checkPreconditions(request: OAuth4cjRequest): Unit {
        if (request.getOauthParameters().size <= 0) {
            throw OAuth4cjParametersMissingException(request.toString())
        }
    }