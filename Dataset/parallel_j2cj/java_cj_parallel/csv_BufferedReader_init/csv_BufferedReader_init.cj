    init(stream: File, sz: Int64) {
        currentStream = stream
        if (sz <= 0) {
            bufSize = defaultBufferSize
        } else {
            bufSize = sz
        }

        cb = Array<UInt8>(bufSize, item: 0)
        nextChar = 0
        nChars = 0
    }