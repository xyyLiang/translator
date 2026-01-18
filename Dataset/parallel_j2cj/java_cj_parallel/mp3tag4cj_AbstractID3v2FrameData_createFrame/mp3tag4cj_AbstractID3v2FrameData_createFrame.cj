    protected open func createFrame(bytes: Array<Int8>, currentOffset: Int32): ID3v2Frame {
        if (obseleteFormat) {
            return ID3v2ObseleteFrame(bytes, currentOffset)
        }
        var id3v2Frame: ID3v2Frame = ID3v2Frame(bytes, currentOffset)
        id3v2Frame.unpackFrame(bytes, currentOffset)
        return id3v2Frame
    }