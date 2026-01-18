    public func executeAsync(request: OAuth4cjRequest): Future<Any> {
        return execute(request, Option<OAuthAsyncRequestCallback>.None)
    }