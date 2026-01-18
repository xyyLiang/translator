    public func getLengthInBytes(): Int32 {
        var length: Int64
        var pad: Int32
        if (padding) {
            pad = 1
        } else {
            pad = 0
        }
        if (layer == 1) {
            length = Int64(((48000 * bitrate) / sampleRate) + (pad * 4))
        } else {
            length = Int64(((144000 * bitrate) / sampleRate) + pad)
        }
        return Int32(length)
    }