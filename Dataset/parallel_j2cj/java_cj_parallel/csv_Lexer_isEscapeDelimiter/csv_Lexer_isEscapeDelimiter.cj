    func isEscapeDelimiter(): Bool {
        var count = reader.lookAhead(escapeDelimiterBuf);

        // If the number of read characters is not equal to the length of escapedelimiterbuf, the advance flow ends
        if (count != escapeDelimiterBuf.size) {
            return false
        }
        if (escapeDelimiterBuf[0] != delimiter[0]) {
            return false
        }

        var i = 1
        while (i < delimiter.size) {
            if (escapeDelimiterBuf[2 * i] != delimiter[i] || escapeDelimiterBuf[2 * i - 1] != escape) {
                return false
            }
            i++
        }

        count = reader.read(escapeDelimiterBuf)
        return count == escapeDelimiterBuf.size
    }