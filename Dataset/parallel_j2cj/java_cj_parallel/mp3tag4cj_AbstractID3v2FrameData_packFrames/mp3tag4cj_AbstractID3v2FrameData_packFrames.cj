    public open func packFrames(bytes: Array<Int8>, offset: Int32): Int32 {
        var newOffset: Int32 = packSpecifiedFrames(bytes, offset, Option<String>.None, "APIC")
        newOffset = packSpecifiedFrames(bytes, newOffset, "APIC", Option<String>.None)
        return newOffset
    }