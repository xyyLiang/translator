    @Override
    public void sendException(String id, Exception response) {
        logWithHandler(id, MessageType.RESPONSE_ERROR, response.getLocalizedMessage(), 0);
    }