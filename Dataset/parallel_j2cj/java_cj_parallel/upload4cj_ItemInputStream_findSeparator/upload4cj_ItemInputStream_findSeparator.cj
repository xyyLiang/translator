    private func findSeparator(): Unit {
        pos = mMultiPartStream.getOrThrow().findSeparator()
        if (pos == -1) {
            if (mMultiPartStream.getOrThrow().tail - mMultiPartStream.getOrThrow().head > mMultiPartStream.getOrThrow().
            keepRegion) {
                pad = mMultiPartStream.getOrThrow().keepRegion
            } else {
                pad = mMultiPartStream.getOrThrow().tail - mMultiPartStream.getOrThrow().head
            }
        }
    }