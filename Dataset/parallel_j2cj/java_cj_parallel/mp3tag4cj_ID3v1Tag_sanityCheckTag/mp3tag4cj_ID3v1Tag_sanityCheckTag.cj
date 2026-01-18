    private func sanityCheckTag(bytes: Array<Byte>): Unit {
        if (bytes.size != Int64(TAG_LENGTH)) {
            throw NoSuchTagException("Buffer length wrong")
        }
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, 0, Int32(TAG.size))) {
            case Some(x) =>
                if (TAG != x) {
                    throw NoSuchTagException("sanityCheckTag fail")
                }
            case None => ()
        }
    }