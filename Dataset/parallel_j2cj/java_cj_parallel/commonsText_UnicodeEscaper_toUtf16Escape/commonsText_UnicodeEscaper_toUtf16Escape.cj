    protected open func toUtf16Escape(codePoint: Char): String {
        return "\\u" + hex(UInt32(codePoint))
    }