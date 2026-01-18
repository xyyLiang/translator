    public static func detectCharset(inputStream: InputStream): String {
        var tempBuf: Array<Byte> = Array<Byte>(4096, item: 0)
        if ((inputStream as Seekable).getOrThrow().length <= 0) {
            throw ChardetException("this inputStream is empty")
        }
        var detector: UniversalDetector = UniversalDetector(CharsetListener())

        while (true) {
            var readNum = inputStream.read(tempBuf)
            if (readNum <= 0) {
                (inputStream as Resource)?.close()
                break
            } 
            let utf8data = tempBuf[0..readNum]
            detector.handleData(utf8data, 0, Int32(readNum))
        }
        detector.dataEnd()

        let encoding: String = detector.getDetectedCharset()
        detector.reset()
        return encoding
    }