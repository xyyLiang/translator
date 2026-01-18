    @Override public Map<String, List<String>> getResponseHeaderFields() {
        return response == null ? null : response.headers().toMultimap();
    }