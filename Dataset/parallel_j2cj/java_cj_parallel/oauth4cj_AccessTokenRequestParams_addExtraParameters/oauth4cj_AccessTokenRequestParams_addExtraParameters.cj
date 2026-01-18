    public func addExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams {
        if (extraParameters.isEmpty()) {
            return this
        }
        this.extraParameters.putAll(extraParameters)
        return this
    }