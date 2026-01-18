    public AuthorizationUrlBuilder initPKCE() {
        this.pkce = PKCEService.defaultInstance().generatePKCE();
        return this;
    }