    public init(input: InputStream, boundary: Option<Array<UInt8>>, pNotifier: Option<ProgressNotifier>) {
        this(input, boundary, DEFAULT_BUFSIZE, pNotifier)
    }