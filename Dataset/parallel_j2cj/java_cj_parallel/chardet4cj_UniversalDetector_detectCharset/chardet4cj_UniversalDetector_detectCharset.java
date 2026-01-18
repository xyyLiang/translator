    public static String detectCharset(Path path) throws IOException {
        try (InputStream fis = new BufferedInputStream(Files.newInputStream(path))) {
            return detectCharset(fis);
        }
    }