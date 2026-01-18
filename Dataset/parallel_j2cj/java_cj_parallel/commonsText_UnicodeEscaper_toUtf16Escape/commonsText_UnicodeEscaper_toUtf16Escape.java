    protected String toUtf16Escape(final int codePoint) {
        return "\\u" + hex(codePoint);
    }