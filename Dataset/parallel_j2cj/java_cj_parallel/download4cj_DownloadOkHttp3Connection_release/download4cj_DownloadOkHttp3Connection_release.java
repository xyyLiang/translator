    @Override public void release() {
        request = null;
        if (response != null) response.close();
        response = null;
    }