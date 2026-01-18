    private func read1(cbuf: Array<UInt8>, off: Int64, len: Int64) {
        if (nextChar >= nChars) {
            /* If the requested length is at least as large as the buffer, and
               if there is no mark/reset activity, do not bother to copy the characters into the
               local buffer.  In this way buffered streams will cascade
               harmlessly. */
            if (len >= bufSize && markedChar <= UNMARKED) {
                return currentStream.read(cbuf[off..len]);
            }
            fill();
        }
        if (nextChar >= nChars) {
            return 0;
        }
        let n = math.min(len, nChars - nextChar);
        cb.copyTo(cbuf, nextChar, off, n)
        nextChar += n
        return n
    }