    public void addQuerystring(String queryString) {
        if (queryString != null && !queryString.isEmpty()) {
            for (String param : queryString.split(PARAM_SEPARATOR)) {
                final String[] pair = param.split(PAIR_SEPARATOR);
                final String key = OAuthEncoder.decode(pair[0]);
                final String value = pair.length > 1 ? OAuthEncoder.decode(pair[1]) : EMPTY_STRING;
                params.add(new Parameter(key, value));
            }
        }
    }