    protected func findSeparator(): Int64 {
        var bufferPos: Int64 = this.head
        var tableP: Int64 = 0
        while (bufferPos < this.tail) {
            while (tableP >= 0 && buffer[bufferPos] != boundary[tableP]) {
                tableP = boundaryTable[tableP]
            }
            bufferPos++
            tableP++
            if (tableP == boundaryLength) {
                let separator: Int64 = bufferPos - boundaryLength
                return separator
            }
        }
        return -1
    }