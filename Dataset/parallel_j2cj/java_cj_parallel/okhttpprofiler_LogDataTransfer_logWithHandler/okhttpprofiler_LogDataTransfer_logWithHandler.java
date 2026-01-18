    private void logWithHandler(String id, MessageType type, String message, int partsCount) {
        if (mHandler == null) return;
        Message handlerMessage = mHandler.obtainMessage();
        String tag = LOG_PREFIX + DELIMITER + id + DELIMITER + type.name;
        Bundle bundle = new Bundle();
        bundle.putString(KEY_TAG, tag);
        bundle.putString(KEY_VALUE, message);
        bundle.putInt(KEY_PARTS_COUNT, partsCount);
        handlerMessage.setData(bundle);
        mHandler.sendMessage(handlerMessage);
    }