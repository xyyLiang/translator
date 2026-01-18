    private func scanBlock(bytes: Array<Int8>, bytesRead: Int32, absoluteOffset: Int32, offsetSrc: Int32): Int32 {
        var offsets: Int32 = offsetSrc
        while (offsets < bytesRead - MINIMUM_BUFFER_LENGTH) {
            var frame: MpegFrame = MpegFrame(
                bytes[Int64(offsets)],
                bytes[Int64(offsets) + 1],
                bytes[Int64(offsets) + 2],
                bytes[Int64(offsets) + 3]
            )
            sanityCheckFrame(frame, absoluteOffset + offsets)
            var newEndOffset: Int32 = absoluteOffset + offsets + frame.getLengthInBytes() - 1
            if (newEndOffset < maxEndOffset()) {
                endOffset = absoluteOffset + offsets + frame.getLengthInBytes() - 1
                frameCounts++
                addBitrates(frame.getBitrate())
                offsets += frame.getLengthInBytes()
            } else {
                break
            }
        }
        return offsets
    }