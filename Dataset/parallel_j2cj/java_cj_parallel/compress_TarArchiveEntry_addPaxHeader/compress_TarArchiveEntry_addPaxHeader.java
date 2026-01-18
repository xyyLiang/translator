    public void addPaxHeader(final String name, final String value) {
        try {
            processPaxHeader(name, value);
        } catch (final IOException ex) {
            throw new IllegalArgumentException("Invalid input", ex);
        }
    }