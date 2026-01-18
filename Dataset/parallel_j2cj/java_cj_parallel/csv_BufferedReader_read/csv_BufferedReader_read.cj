    func read(): Option<UInt8> {
        if (nextChar >= nChars) {
            fill();
            if (nextChar >= nChars) {
                return Option<UInt8>.None;
            }
        }
        nextChar++
        cb[nextChar - 1]
    }