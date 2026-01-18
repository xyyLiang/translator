    public void put(HttpHeaders headers) {
        if (headers != null) {
            if (headers.headersMap != null && !headers.headersMap.isEmpty()) headersMap.putAll(headers.headersMap);
        }
    }