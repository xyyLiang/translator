    public void log(String message) {
        if (debugStream != null) {
            log(message, (Object[]) null);
        }
    }