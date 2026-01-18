    public func unpack(i: Int32): Int32 {
        return ((this.data[Int64(i>>this.indexShift)] >> ((i&this.shiftMask)<<this.bitShift)) & this.unitMask)
                
    }