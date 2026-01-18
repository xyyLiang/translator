    public void writeEntryHeader(final byte[] outbuf) {
        try {
            writeEntryHeader(outbuf, TarUtils.DEFAULT_ENCODING, false);
        } catch (final IOException ex) { // NOSONAR
            try {
                writeEntryHeader(outbuf, TarUtils.FALLBACK_ENCODING, false);
            } catch (final IOException ex2) {
                // impossible
                throw new UncheckedIOException(ex2); // NOSONAR
            }
        }
    }