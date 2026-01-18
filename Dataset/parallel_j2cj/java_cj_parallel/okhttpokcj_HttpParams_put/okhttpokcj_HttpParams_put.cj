    public func put(params: HttpParams): Unit {
        if (!(params.urlParamsMap.isEmpty())) {
            urlParamsMap.putAll(params.urlParamsMap)
        }
        if (!(params.fileParamsMap.isEmpty())) {
            fileParamsMap.putAll(params.fileParamsMap)
        }
    }