    protected func skip(bytes: Int64): Int64 {
        if (closed) {
            throw ItemSkippedException("Skip Fail")
        }
        var av = available()
        if (av == 0) {
            av = makeAvailable()
            if (av == 0) {
                return 0
            }
        }
        let res: Int64 = min(av, bytes)
        mMultiPartStream.getOrThrow().head += res
        return res
    }