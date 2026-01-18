    boolean isDelimiter(final int ch) throws IOException {
        isLastTokenDelimiter = false;
        if (ch != delimiter[0]) {
            return false;
        }
        if (delimiter.length == 1) {
            isLastTokenDelimiter = true;
            return true;
        }
        reader.lookAhead(delimiterBuf);
        for (int i = 0; i < delimiterBuf.length; i++) {
            if (delimiterBuf[i] != delimiter[i+1]) {
                return false;
            }
        }
        final int count = reader.read(delimiterBuf, 0, delimiterBuf.length);
        isLastTokenDelimiter = count != END_OF_STREAM;
        return isLastTokenDelimiter;
    }