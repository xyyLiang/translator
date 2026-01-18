    public func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {_ => 0})
        if (comment != Option<EncodedText>.None) {
            bytes[0] = comment.getOrThrow().getTextEncoding()
        } else {
            bytes[0] = 0
        }
        var langPadded: String
        if (language == Option<String>.None) {
            langPadded = DEFAULT_LANGUAGE
        } else if (language.getOrThrow().size > 3) {
            langPadded = language.getOrThrow()[..3]
        } else {
            langPadded = BufferTools.padStringRight(language.getOrThrow(), 3, '\u{0}')
        }
        try {
            BufferTools.stringIntoByteBuffer(langPadded, 0, 3, bytes, 1)
        } catch (e: Exception) {}
        var marker: Int32 = 4
        if (description != Option<EncodedText>.None) {
            var descriptionBytes: Array<Int8> = description.getOrThrow().toBytes(true, true)
            BufferTools.copyIntoByteBuffer(descriptionBytes, 0, descriptionBytes.size, bytes, Int64(marker))
            marker += Int32(descriptionBytes.size)
        } else {
            var terminatorBytes: Array<Int8>
            if (comment != Option<EncodedText>.None) {
                terminatorBytes = comment.getOrThrow().getTerminator()
            } else {
                terminatorBytes = [0]
            }
            BufferTools.copyIntoByteBuffer(terminatorBytes, 0, terminatorBytes.size, bytes, Int64(marker))
            marker += Int32(terminatorBytes.size)
        }
        if (comment != Option<EncodedText>.None) {
            var commentBytes: Array<Int8> = comment.getOrThrow().toBytes(true, false)
            BufferTools.copyIntoByteBuffer(commentBytes, 0, commentBytes.size, bytes, Int64(marker))
        }
        return bytes
    }