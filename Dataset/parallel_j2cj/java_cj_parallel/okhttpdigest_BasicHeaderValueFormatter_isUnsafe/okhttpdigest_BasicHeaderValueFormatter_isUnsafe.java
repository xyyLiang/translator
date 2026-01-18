    protected boolean isUnsafe(char ch) {
        return "\"\\".indexOf(ch) >= 0;
    }