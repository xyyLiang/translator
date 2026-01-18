    public func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {_ => 0})
        if (description != Option<EncodedText>.None) {
            bytes[0] = description.getOrThrow().getTextEncoding()
        } else {
            bytes[0] = 0
        }
        var marker: Int32 = 1
        if (description != Option<EncodedText>.None) {
            var descriptionBytes: Array<Int8> = description.getOrThrow().toBytes(true, true)
            BufferTools.copyIntoByteBuffer(descriptionBytes, 0, descriptionBytes.size, bytes, Int64(marker))
            marker += Int32(descriptionBytes.size)
        } else {
            marker++
            bytes[Int64(marker)] = 0
        }
        if (url != Option<String>.None && url.getOrThrow().size > 0) {
            try {
                BufferTools.stringIntoByteBuffer(url.getOrThrow(), 0, url.getOrThrow().size, bytes, Int64(marker))
            } catch (e: Exception) {}
        }
        return bytes
    }