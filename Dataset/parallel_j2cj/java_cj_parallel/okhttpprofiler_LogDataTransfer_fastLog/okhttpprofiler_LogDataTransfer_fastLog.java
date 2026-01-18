    @SuppressLint("LogNotTimber")
    private void fastLog(String id, MessageType type, String message) {
        String tag = LOG_PREFIX + DELIMITER + id + DELIMITER + type.name;
        if (message != null) {
            Log.v(tag, message);
        }
    }