    protected override func toUtf16Escape(codePoint: Char): String {
        let highSurrogate: UInt32 = ((UInt32(codePoint) - 0x10000u32) >> 10) + 0xD800u32
        let lowSurrogate: UInt32 = (UInt32(codePoint) & 0x3FFu32) + 0xDC00u32
        return "\\u" + hex(highSurrogate) + "\\u" + hex(lowSurrogate)
    }