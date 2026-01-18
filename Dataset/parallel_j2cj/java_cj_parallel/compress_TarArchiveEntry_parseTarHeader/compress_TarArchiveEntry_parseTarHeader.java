    public void parseTarHeader(final byte[] header) {
        try {
            parseTarHeader(header, TarUtils.DEFAULT_ENCODING);
        } catch (final IOException ex) { // NOSONAR
            try {
                parseTarHeader(header, TarUtils.DEFAULT_ENCODING, true, false);
            } catch (final IOException ex2) {
                // not really possible
                throw new UncheckedIOException(ex2); // NOSONAR
            }
        }
    }