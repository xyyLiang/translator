    public AccessTokenRequestParams addExtraParameter(String name, String value) {
        if (this.extraParameters == null) {
            extraParameters = new HashMap<>();
        }
        this.extraParameters.put(name, value);
        return this;
    }