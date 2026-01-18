    public static func addCacheHeaders(request: okhttp_okcj.Request, cacheEntity: CacheEntity, cacheMode: CacheMode): Unit {
        
        if (cacheMode == CacheMode.DEFAULT) {
            var responseHeaders: HttpHeaders = cacheEntity.getResponseHeaders()
            var eTag: String = responseHeaders.get(HttpHeaders.HEAD_KEY_E_TAG).getOrThrow()
            if (!(eTag.isEmpty())) {
                request.getHeaders(HttpHeaders.HEAD_KEY_IF_NONE_MATCH, eTag)
            }
        }
    }