    @OverflowWrapping
    public open func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = Int32(super.hashCode())
        if (description == Option<EncodedText>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(description.getOrThrow().hashCode())
        }
        if (imageData == Option<Array<Int8>>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(imageData.getOrThrow().toString().hashCode())
        }
        if (mimeType == Option<String>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(mimeType.getOrThrow().hashCode())
        }
        result = prime * result + Int32(pictureType)
        return Int64(result)
    }