    protected func _toLong(buffer: Array<UInt8>, offset: Int64): Int64
    {
        let l1: Int64 = _toInt(buffer, offset)
        let l2: Int64 = _toInt(buffer, offset+4)
        let l: Int64 = (l1 << 32) + rightShift((l2 << 32), 32)
        return l
    }