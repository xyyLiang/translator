    public static long copy(InputStream inputStream, OutputStream outputStream, boolean closeOutputStream)
            throws IOException {
        return copy(inputStream, outputStream, closeOutputStream, new byte[DEFAULT_BUFFER_SIZE]);
    }