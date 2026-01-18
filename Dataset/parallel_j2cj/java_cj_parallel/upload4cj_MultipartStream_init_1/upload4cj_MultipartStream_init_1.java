    MultipartStream(InputStream input,
            byte[] boundary,
            ProgressNotifier pNotifier) {
        this(input, boundary, DEFAULT_BUFSIZE, pNotifier);
    }