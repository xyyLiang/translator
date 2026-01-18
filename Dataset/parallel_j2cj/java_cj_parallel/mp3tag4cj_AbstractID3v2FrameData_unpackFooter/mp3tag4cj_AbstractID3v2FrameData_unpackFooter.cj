    private func unpackFooter(bytes: Array<Int8>, offset: Int32): Int32 {
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(
            bytes,
            offset,
            Int32(FOOTER_TAG.size)
        )) {
            case Some(x) =>
                if (FOOTER_TAG != x) {
                    throw InvalidDataException("Invalid footer")
                }
            case None => throw InvalidDataException("Invalid footer")
        }
        return FOOTER_LENGTH
    }