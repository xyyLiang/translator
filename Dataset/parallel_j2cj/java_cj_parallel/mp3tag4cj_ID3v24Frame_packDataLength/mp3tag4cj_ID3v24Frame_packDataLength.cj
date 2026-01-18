    protected func packDataLength(): Array<Int8> {
        return BufferTools.packSynchsafeInteger(dataLength)
    }