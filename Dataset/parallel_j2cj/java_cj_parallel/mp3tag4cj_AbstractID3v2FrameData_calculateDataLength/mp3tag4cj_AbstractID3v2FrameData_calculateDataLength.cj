    private func calculateDataLength(): Int32 {
        var length: Int32 = 0
        if (extendedHeader) {
            length += extendedHeaderLength
        }
        if (footer) {
            length += FOOTER_LENGTH
        } else if (padding) {
            length += PADDING_LENGTH
        }
        for (frameSet in frameSets.values()) {
            for (frame in frameSet.getFrames()) {
                length += frame.getLength()
            }
        }
        return length
    }