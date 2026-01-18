    public func put(headers: HttpHeaders) {

        if (!(headers.headersMap.isEmpty())) {
            headersMap.putAll(headers.headersMap)
        }
    }