    public String build() {
        final StringBuilder scopeBuilder = new StringBuilder();
        for (String scope : scopes) {
            scopeBuilder.append(' ').append(scope);
        }
        return scopeBuilder.substring(1);
    }