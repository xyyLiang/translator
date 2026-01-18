    public init(input: InputStream, capacity: Int64, charset: Charset) {
        if (capacity <  0) {
            throw DiskLruCacheException("the capacity of strictLineReader cannot be negative")
        }
        if (!(charset.nameEquals("ISO-8859-2"))) {
            throw DiskLruCacheException("unsupported encoding")
        }
        this.input = input
        this.charset = charset
        this.buf = Array<Byte>(capacity, item:0)
    }