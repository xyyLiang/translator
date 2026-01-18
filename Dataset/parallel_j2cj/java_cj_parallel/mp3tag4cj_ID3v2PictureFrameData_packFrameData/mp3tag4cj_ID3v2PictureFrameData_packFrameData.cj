    public open func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {_ => 0})
        if (description != Option<EncodedText>.None) {
            bytes[0] = description.getOrThrow().getTextEncoding()
        } else {
            bytes[0] = 0
        }
        var mimeTypeLength: Int64 = 0
        if (mimeType != Option<String>.None) {
            if (mimeType.getOrThrow().size > 0) {
                mimeTypeLength = mimeType.getOrThrow().toArray().size
                try {
                    BufferTools.stringIntoByteBuffer(mimeType.getOrThrow(), 0, mimeType.getOrThrow().size, bytes, 1)
                } catch (e: Exception) {}
            }
        }
        var marker: Int64 = mimeTypeLength + 1
        bytes[marker] = 0
        marker++
        bytes[marker] = pictureType
        marker++
        if (description != Option<EncodedText>.None) {
            if (description.getOrThrow().toBytes().size > 0) {
                var descriptionBytes: Array<Int8> = description.getOrThrow().toBytes(true, true)
                BufferTools.copyIntoByteBuffer(descriptionBytes, 0, descriptionBytes.size, bytes, marker)
                marker += descriptionBytes.size
            }else {
                marker++
                bytes[marker] = 0
            }
        } else {
            marker++
            bytes[marker] = 0
        }
        if (imageData != Option<Array<Int8>>.None) {
            if (imageData.getOrThrow().size > 0) {
                BufferTools.copyIntoByteBuffer(imageData.getOrThrow(), 0, imageData.getOrThrow().size, bytes, marker)
            }
        }
        return bytes
    }