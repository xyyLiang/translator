    public AccessTokenRequestParams addExtraParameters(Map<String, String> extraParameters) {
        if (extraParameters == null || extraParameters.isEmpty()) {
            return this;
        }
        if (this.extraParameters == null) {
            extraParameters = new HashMap<>();
        }
        this.extraParameters.putAll(extraParameters);
        return this;
    }