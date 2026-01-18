    @OverflowWrapping
    public func generate(): UUID {
        // Ok, get 60-bit timestamp (4 MSB are ignored)
        let rawTimestamp: Int64 = _timer.getTimestamp()
        // First: discard 4 MSB, next 32 bits (top of 60-bit timestamp) form the
        // highest 32-bit segments
        let timestampHigh: Int64 = rightShift(rawTimestamp, 28) << 32
        // and then bottom 28 bits split into mid (16 bits), low (12 bits)
        let timestampLow: Int32 = Int32(rawTimestamp)
        // and then low part gets mixed with variant identifier
        let timeBottom: Int32 = (((timestampLow >> 12) & 0xFFFF) << 16) | 0x6000 | (timestampLow & 0xFFF)
        var timeBottomL: Int64 = Int64(timeBottom)
        timeBottomL = rightShift((timeBottomL << 32), 32)
        // and reconstruct
        var l1:Int64 = timestampHigh | timeBottomL
        let timeArray: Array<UInt8> = Int8ToUInt8(UUIDUtil.int64asByteArray(l1, _uuidL2))
        return UUID(timeArray)
    }