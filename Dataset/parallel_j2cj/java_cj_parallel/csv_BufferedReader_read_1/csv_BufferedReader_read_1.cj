    func read(cbuf: Array<UInt8>, off: Int64, len: Int64) {
        if ((off < 0) || (off > bufSize) || (len < 0) || ((off + len) > bufSize) || ((off + len) < 0)) {
            throw IndexOutOfBoundsException();
        } else if (len == 0) {
            return 0;
        }
        var n = read1(cbuf, off, len);
        if (n <= 0) {
            return n
        }

        while (n < len) {
            let n1 = read1(cbuf, off + n, len - n);
            if (n1 <= 0) {
                break
            }
            n += n1
        }
        return n
    }