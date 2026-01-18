    @Override public String getResponseHeaderField(String name) {
        return response == null ? null : response.header(name);
    }