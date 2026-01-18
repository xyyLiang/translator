 private boolean isAsciiSymbol(byte b) {
        int c = b & 0xFF;
        return ((c < ASCII_A_CAPITAL) ||
                (c > ASCII_Z_CAPITAL && c < ASCII_A) ||
                (c > ASCII_Z));
    }