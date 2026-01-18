    public static String getStreamContents(InputStream is) throws IOException {
        Preconditions.checkNotNull(is, "Cannot get String from a null object");
        final char[] buffer = new char[0x10000];
        final StringBuilder out = new StringBuilder();
        try (Reader in = new InputStreamReader(is, "UTF-8")) {
            int read;
            do {
                read = in.read(buffer, 0, buffer.length);
                if (read > 0) {
                    out.append(buffer, 0, read);
                }
            } while (read >= 0);
        }
        return out.toString();
    }