    protected static func  _toLong(buffer: Array<UInt8>, offset: Int64): Int64 {
        var l1:Int64 = _toInt(buffer, offset)
        var l2:Int64 = _toInt(buffer, offset + 4)
        let l = (l1 << 32) + rightShift((l2 << 32), 32)
        return l
    }