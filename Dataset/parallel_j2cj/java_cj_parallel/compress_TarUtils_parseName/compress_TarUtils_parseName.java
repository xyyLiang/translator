    public static String parseName(final byte[] buffer, final int offset, final int length) {
        try {
            return parseName(buffer, offset, length, DEFAULT_ENCODING);
        } catch (final IOException ex) { // NOSONAR
            try {
                return parseName(buffer, offset, length, FALLBACK_ENCODING);
            } catch (final IOException ex2) {
                // impossible
                throw new UncheckedIOException(ex2); // NOSONAR
            }
        }
    }