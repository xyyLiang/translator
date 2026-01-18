    protected open func createFrame(id: String, data: Array<Int8>): ID3v2Frame {
        if (obseleteFormat) {
            return ID3v2ObseleteFrame(id, data)
        } else {
            return ID3v2Frame(id, data)
        }
    }