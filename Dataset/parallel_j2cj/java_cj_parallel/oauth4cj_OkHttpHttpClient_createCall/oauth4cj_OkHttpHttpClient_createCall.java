    private Call createCall(String userAgent, Map<String, String> headers, Verb httpVerb, String completeUrl,
            BodyType bodyType, Object bodyContents) {
        final Request.Builder requestBuilder = new Request.Builder();
        requestBuilder.url(completeUrl);

        final String method = httpVerb.name();

        // prepare body
        final RequestBody body;
        if (bodyContents != null && HttpMethod.permitsRequestBody(method)) {
            final MediaType mediaType = headers.containsKey(CONTENT_TYPE) ? MediaType.parse(headers.get(CONTENT_TYPE))
                    : DEFAULT_CONTENT_TYPE_MEDIA_TYPE;

            body = bodyType.createBody(mediaType, bodyContents);
        } else {
            body = null;
        }

        // fill HTTP method and body
        requestBuilder.method(method, body);

        // fill headers
        for (Map.Entry<String, String> header : headers.entrySet()) {
            requestBuilder.addHeader(header.getKey(), header.getValue());
        }

        if (userAgent != null) {
            requestBuilder.header(OAuthConstants.USER_AGENT_HEADER_NAME, userAgent);
        }

        // create a new call
        return client.newCall(requestBuilder.build());
    }