    public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>): Future<Any> {
        return execute(request, callback, Option<ResponseConverter>.None)
    }