    public static func copy(inputStream: Option<InputStream>, outputStream: Option<OutputStream>,
        closeOutputStream: Bool): Int64 {
        return copy(inputStream, outputStream, closeOutputStream, Array<UInt8>(DEFAULT_BUFFER_SIZE, item: 0))
    }