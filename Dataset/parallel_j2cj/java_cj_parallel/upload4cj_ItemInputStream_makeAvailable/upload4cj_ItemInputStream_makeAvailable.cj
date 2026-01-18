    private func makeAvailable(): Int64 {
        if (pos != -1) {
            return 0
        }
        total = total + (mMultiPartStream.getOrThrow().tail - mMultiPartStream.getOrThrow().head - pad)
        mMultiPartStream.getOrThrow().buffer.copyTo(
            mMultiPartStream.getOrThrow().buffer,
            mMultiPartStream.getOrThrow().tail - pad,
            0,
            pad
        )
        mMultiPartStream.getOrThrow().head = 0
        mMultiPartStream.getOrThrow().tail = pad

        while (true) {
            var bytesRead: Int64 = mMultiPartStream.getOrThrow().input.read(mMultiPartStream.getOrThrow().buffer[mMultiPartStream.getOrThrow().tail..mMultiPartStream.
                getOrThrow().bufSize])

            if (bytesRead <= 0) {
                throw MalformedStreamException("Stream ended unexpectedly");
            }

            if (let Some(i) <- mMultiPartStream.getOrThrow().notifier) {
                i.noteBytesRead(bytesRead)
            }

            mMultiPartStream.getOrThrow().tail = mMultiPartStream.getOrThrow().tail + bytesRead
            findSeparator()
            let av: Int64 = available()

            if (av > 0 || pos != -1) {
                return av
            }
        }
        return 0
    }