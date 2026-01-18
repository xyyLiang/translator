    static func appendBytes(
        content: String,
        mode: Mode,
        bits: BitArray
    ) {
        match (mode) {
            case NUMERIC => appendNumericBytes(content, bits)
            case ALPHANUMERIC => appendAlphanumericBytes(content, bits)
            case BYTE => append8BitBytes(content, bits)
            case KANJI => appendKanjiBytes(content, bits)
            case _ => throw WriterException("Invalid mode: ${mode}")
        }
    }