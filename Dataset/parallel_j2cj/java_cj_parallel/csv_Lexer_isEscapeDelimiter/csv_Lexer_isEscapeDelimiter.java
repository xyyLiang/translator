    boolean isEscapeDelimiter() throws IOException {
        reader.lookAhead(escapeDelimiterBuf);
        if (escapeDelimiterBuf[0] != delimiter[0]) {
            return false;
        }
        for (int i = 1; i < delimiter.length; i++) {
            if (escapeDelimiterBuf[2 * i] != delimiter[i] || escapeDelimiterBuf[2 * i - 1] != escape) {
                return false;
            }
        }
        final int count = reader.read(escapeDelimiterBuf, 0, escapeDelimiterBuf.length);
        return count != END_OF_STREAM;
    }