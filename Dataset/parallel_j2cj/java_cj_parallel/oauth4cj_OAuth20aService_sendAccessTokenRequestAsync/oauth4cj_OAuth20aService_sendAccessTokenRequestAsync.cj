    protected func sendAccessTokenRequestAsync(request: OAuth4cjRequest): Future<OAuth2AccessToken> {
        return sendAccessTokenRequestAsync(request, None)
    }