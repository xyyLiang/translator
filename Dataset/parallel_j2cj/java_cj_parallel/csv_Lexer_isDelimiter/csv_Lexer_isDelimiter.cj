    func isDelimiter(ch: Rune): Bool {
        if (ch != delimiter[0]) {
            return false
        }

        if (delimiter.size == 1) {
            return true
        }

        let count = reader.lookAhead(delimiterBuf);

        // The read content is incomplete and is not considered as a separator
        if (count != delimiterBuf.size) {
            return false
        }

        var i = 0
        while (i < count) {
            if (delimiterBuf[i] != delimiter[i + 1]) {
                return false
            }
            i++
        }

        reader.read(delimiterBuf, 0, delimiterBuf.size);

        return true
    }