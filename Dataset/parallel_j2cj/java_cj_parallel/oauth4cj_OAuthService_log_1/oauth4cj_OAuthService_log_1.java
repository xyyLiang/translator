    public void log(String messagePattern, Object... params) {
        final String message = String.format(messagePattern, params) + '\n';
        try {
            debugStream.write(message.getBytes("UTF8"));
        } catch (IOException | RuntimeException e) {
            throw new RuntimeException("there were problems while writting to the debug stream", e);
        }
    }