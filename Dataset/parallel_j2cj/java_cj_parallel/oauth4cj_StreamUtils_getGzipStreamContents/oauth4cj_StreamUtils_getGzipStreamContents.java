    public static String getGzipStreamContents(InputStream is) throws IOException {
        Preconditions.checkNotNull(is, "Cannot get String from a null object");
        final GZIPInputStream gis = new GZIPInputStream(is);
        return getStreamContents(gis);
    }