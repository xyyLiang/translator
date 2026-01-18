    public open func getClientAuthentication(): ClientAuthentication {
        return HttpBasicAuthenticationScheme.instance()
    }
