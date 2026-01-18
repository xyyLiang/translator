    public override func generate():UUID{
        let rawTimestamp:Int64 = _timer.getTimestamp()
        let clockHi:Int64 = Int64(rightShift(rawTimestamp,32))
        let clockLo:Int64 = Int64(rawTimestamp)

        var midhi:Int64 = (clockHi << 16) | rightShift(clockHi,16)

        midhi &= !0xF000
        midhi |= 0x1000
        var midhiL:Int64 = Int64(midhi);
        midhiL = rightShift((midhiL << 32), 32)
        var l1: Int64 = (Int64(clockLo) << 32) | midhiL

        let timeArray: Array<UInt8> = Int8ToUInt8(UUIDUtil.int64asByteArray(l1, _uuidL2))
        return UUID(timeArray)
    }