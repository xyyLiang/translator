    protected func available(): Int64 {
        if (pos == -1) {
            return mMultiPartStream.getOrThrow().tail - mMultiPartStream.getOrThrow().head - pad
        }
        return pos - mMultiPartStream.getOrThrow().head
    }