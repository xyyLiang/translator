    public func clockSequence(): Int32 {
        if (version() != 1) {
            throw UnsupportedOperationException ("Not a time-based UUID")
        }

        let clockSequenceBytes = Array<Byte>(2, item: 0)
        this.bytes.copyTo(clockSequenceBytes, 8, 0, 2)
        clockSequenceBytes[0] &= 0x3f
        return Int32.parse("0x" + toHexString(clockSequenceBytes))
    }  