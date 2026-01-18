    public func addParameter(key: String, value: String): Unit {
        if (verb.isPermitBody()) {
            this.bodyParams.add(key, value)
        } else {
            this.querystringParams.add(key, value)
        }
    }