    static Response convertResponse(okhttp3.Response okHttpResponse) {
        final Headers headers = okHttpResponse.headers();
        final Map<String, String> headersMap = new HashMap<>();
        for (String headerName : headers.names()) {
            headersMap.put(headerName, headers.get(headerName));
        }

        final ResponseBody body = okHttpResponse.body();
        final InputStream bodyStream = body == null ? null : body.byteStream();
        return new Response(okHttpResponse.code(), okHttpResponse.message(), headersMap, bodyStream, bodyStream, body,
                okHttpResponse);
    }