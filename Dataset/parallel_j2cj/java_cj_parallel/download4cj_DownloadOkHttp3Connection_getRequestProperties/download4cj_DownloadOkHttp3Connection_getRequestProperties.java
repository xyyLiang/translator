    @Override public Map<String, List<String>> getRequestProperties() {
        if (request != null) {
            return request.headers().toMultimap();
        } else {
            return requestBuilder.build().headers().toMultimap();
        }
    }