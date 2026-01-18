    public override func read(buffer: Array<Byte>): Int64 {
        if (closed) {
            throw ItemSkippedException("Read Fail")
        }

        if (buffer.size == 0) {
            return 0
        }

        var res = available()
        if (res == 0) {
            res = makeAvailable()
            if (res == 0) {
                return -1
            }
        }

        res = min(res, buffer.size)

        mMultiPartStream.getOrThrow().buffer.copyTo(buffer, mMultiPartStream.getOrThrow().head, 0, res)
        mMultiPartStream.getOrThrow().head += res
        total += res
        return res
    }