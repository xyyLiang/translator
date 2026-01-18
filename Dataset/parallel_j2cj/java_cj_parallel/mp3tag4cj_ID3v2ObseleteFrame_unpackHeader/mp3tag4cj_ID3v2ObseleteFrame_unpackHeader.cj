    protected override func unpackHeader(buffer: Array<Int8>, offset: Int32): Int32 {
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(
            buffer,
            offset + ID_OFFSET,
            ID_LENGTH
        )) {
            case Some(x) => id = x
            case None => ()
        }
        unpackDataLength(buffer, offset)
        return offset + HEADER_LENGTH
    }