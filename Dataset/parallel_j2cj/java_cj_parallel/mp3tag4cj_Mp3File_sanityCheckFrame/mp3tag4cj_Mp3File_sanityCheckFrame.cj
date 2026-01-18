    private func sanityCheckFrame(frame: MpegFrame, offset: Int32): Unit {
        if (sampleRate != frame.getSampleRate()) {
            throw InvalidDataException("Inconsistent frame header")
        }
        if (layer != frame.getLayer()) {
            throw InvalidDataException("Inconsistent frame header")
        }
        if (version != frame.getVersion()) {
            throw InvalidDataException("Inconsistent frame header")
        }
        if (Int64(offset) + Int64(frame.getLengthInBytes()) > getLength()) {
            throw InvalidDataException("Frame would extend beyond end of file")
        }
    }