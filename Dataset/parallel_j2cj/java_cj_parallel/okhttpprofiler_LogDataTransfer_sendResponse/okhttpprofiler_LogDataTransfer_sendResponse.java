    @Override
    public void sendResponse(String id, Response response) throws IOException {
        ResponseBody responseBodyCopy = response.peekBody(BODY_BUFFER_SIZE);
        largeLog(id, MessageType.RESPONSE_BODY, responseBodyCopy.string());

        Headers headers = response.headers();
        logWithHandler(id, MessageType.RESPONSE_STATUS, String.valueOf(response.code()), 0);
        for (String name : headers.names()) {
            logWithHandler(id, MessageType.RESPONSE_HEADER, name + HEADER_DELIMITER + headers.get(name), 0);
        }
    }