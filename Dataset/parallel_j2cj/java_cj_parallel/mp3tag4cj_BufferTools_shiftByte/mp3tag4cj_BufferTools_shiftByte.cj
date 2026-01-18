    @OverflowWrapping
    public static func shiftByte(c: Int8, places: Int32): Int32 {
        var i: Int32 = Int32(c) & 0xff
        if (places < 0) {
            return i << -places
        } else if (places > 0) {
            var j: UInt32 = UInt32(i)
            j = j >> places
            i = Int32(j)
            return i
        }
        return i
    }