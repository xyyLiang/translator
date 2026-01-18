    public func initPKCE(): AuthorizationUrlBuilder {
        this.pkce = PKCEService.defaultInstance().generatePKCE()
        return this
    }