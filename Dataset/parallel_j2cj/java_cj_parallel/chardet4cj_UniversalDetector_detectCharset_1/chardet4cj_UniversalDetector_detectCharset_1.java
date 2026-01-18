    public static String detectCharset(File file) throws IOException {
        return detectCharset(file.toPath());
    }