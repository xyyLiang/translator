    @OverflowWrapping
    public open func getLength(): Int32 {
        var length: Int32 = 3
        if (mimeType != Option<String>.None) {
            length += Int32(mimeType.getOrThrow().toArray().size)
        }
        if (description != Option<EncodedText>.None) {
            length += Int32(description.getOrThrow().toBytes(true, true).size)
        } else {
            length++
        }
        if (imageData != Option<Array<Int8>>.None) {
            length += Int32(imageData.getOrThrow().size)
        }
        return length
    }