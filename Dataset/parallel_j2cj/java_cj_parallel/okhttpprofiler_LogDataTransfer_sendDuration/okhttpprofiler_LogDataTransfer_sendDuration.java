    @Override
    public void sendDuration(String id, long duration) {
        logWithHandler(id, MessageType.RESPONSE_TIME, String.valueOf(duration), 0);
        logWithHandler(id, MessageType.RESPONSE_END, "-->", 0);
    }