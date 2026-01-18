    public func getClass(b: Byte): Int32 {
        let c = Int32(Int64(b) & 0xFF)
        return this.classTable.unpack(c)
    }