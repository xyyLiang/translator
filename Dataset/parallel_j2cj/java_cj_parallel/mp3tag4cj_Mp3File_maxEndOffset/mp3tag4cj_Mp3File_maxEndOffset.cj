    private func maxEndOffset(): Int32 {
        var maxEndOffset: Int64 = getLength()
        if (hasId3v1Tag()) {
            maxEndOffset -= Int64(ID3v1Tag.TAG_LENGTH)
        }
        return Int32(maxEndOffset)
    }