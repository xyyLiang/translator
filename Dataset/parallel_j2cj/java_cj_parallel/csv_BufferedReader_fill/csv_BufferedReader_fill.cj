    private func fill() {
        let dst: Int64
        if (markedChar <= UNMARKED) {
            /* No mark */
            dst = 0
        } else {
            /* Marked */
            var delta = nextChar - markedChar
            if (delta > readAheadLimit) {
                /* Gone past read-ahead limit: Invalidate mark */
                markedChar = INVALIDATED
                readAheadLimit = 0
                dst = 0
            } else {
                if (readAheadLimit <= bufSize) {
                    /* Shuffle in the current buffer */
                    cb.copyTo(cb, markedChar, 0, delta)
                    markedChar = 0
                    dst = delta
                } else {
                    /* Reallocate buffer to accommodate read-ahead limit */
                    var ncb = Array<UInt8>(readAheadLimit, item: 0);
                    cb.copyTo(ncb, markedChar, 0, delta)
                    cb = ncb
                    bufSize = cb.size
                    markedChar = 0
                    dst = delta
                }
                nextChar = delta
                nChars = delta
            }
        }

        let n = currentStream.read(cb[dst..bufSize])
        nChars = dst + n
        nextChar = dst
    }