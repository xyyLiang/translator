    public static int formatNameBytes(final String name, final byte[] buf, final int offset, final int length) {
        try {
            return formatNameBytes(name, buf, offset, length, DEFAULT_ENCODING);
        } catch (final IOException ex) { // NOSONAR
            try {
                return formatNameBytes(name, buf, offset, length, FALLBACK_ENCODING);
            } catch (final IOException ex2) {
                // impossible
                throw new UncheckedIOException(ex2); // NOSONAR
            }
        }
    }