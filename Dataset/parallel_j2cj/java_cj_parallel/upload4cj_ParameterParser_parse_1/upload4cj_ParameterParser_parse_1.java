    public Map<String, String> parse(final String str, char separator) {
        if (str == null) {
            return new HashMap<String, String>();
        }
        return parse(str.toCharArray(), separator);
    }