    private <T> Future<T> doExecuteAsync(String userAgent, Map<String, String> headers, Verb httpVerb,
            String completeUrl, BodyType bodyType, Object bodyContents, OAuthAsyncRequestCallback<T> callback,
            OAuthRequest.ResponseConverter<T> converter) {
        final Call call = createCall(userAgent, headers, httpVerb, completeUrl, bodyType, bodyContents);
        final OkHttpFuture<T> okHttpFuture = new OkHttpFuture<>(call);
        call.enqueue(new OAuthAsyncCompletionHandler<>(callback, converter, okHttpFuture));
        return okHttpFuture;
    }