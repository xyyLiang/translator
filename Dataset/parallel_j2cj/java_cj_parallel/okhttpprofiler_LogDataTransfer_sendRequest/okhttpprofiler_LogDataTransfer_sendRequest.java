    @Override
    public void sendRequest(String id, Request request) throws IOException {
        fastLog(id, MessageType.REQUEST_METHOD, request.method());
        String url = request.url().toString();
        fastLog(id, MessageType.REQUEST_URL, url);
        fastLog(id, MessageType.REQUEST_TIME, String.valueOf(System.currentTimeMillis()));

        final Request copy = request.newBuilder().build();
        final Buffer buffer = new Buffer();
        RequestBody body = copy.body();

        if (body != null) {
            MediaType type = body.contentType();
            if (type != null) {
                fastLog(id, MessageType.REQUEST_HEADER, CONTENT_TYPE + HEADER_DELIMITER + SPACE + type.toString());
            }
            long contentLength = body.contentLength();
            if (contentLength != -1) {
                fastLog(id, MessageType.REQUEST_HEADER, CONTENT_LENGTH + HEADER_DELIMITER + SPACE + contentLength);
            }
        }

        Headers headers = request.headers();
        for (String name : headers.names()) {
            //We have logged them before
            if (CONTENT_TYPE.equalsIgnoreCase(name) || CONTENT_LENGTH.equalsIgnoreCase(name)) {
                continue;
            }
            fastLog(id, MessageType.REQUEST_HEADER, name + HEADER_DELIMITER + SPACE + headers.get(name));
        }

        if (body != null) {
            body.writeTo(buffer);
            largeLog(id, MessageType.REQUEST_BODY, buffer.readString(Charset.defaultCharset()));
        }
    }