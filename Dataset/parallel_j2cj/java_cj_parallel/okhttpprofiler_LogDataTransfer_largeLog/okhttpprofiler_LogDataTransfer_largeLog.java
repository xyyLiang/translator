    private void largeLog(String id, MessageType type, String content) {
        final int contentLength = content.length();
        if (content.length() > LOG_LENGTH) {
            final int parts = contentLength / LOG_LENGTH;
            for (int i = 0; i <= parts; i++) {
                final int start = i * LOG_LENGTH;
                int end = start + LOG_LENGTH;
                if (end > contentLength) {
                    end = contentLength;
                }
                logWithHandler(id, type, content.substring(start, end), parts);
            }
        } else {
            logWithHandler(id, type, content, 0);
        }
    }