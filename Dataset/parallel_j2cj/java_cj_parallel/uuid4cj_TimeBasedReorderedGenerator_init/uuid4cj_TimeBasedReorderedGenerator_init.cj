    @OverflowWrapping
    public init(ethAddr: ?EthernetAddress, timer: UUIDTimer) {
        let uuidBytes:Array<UInt8> = Array<UInt8>(16, item: 0)
        match(ethAddr) {
            case None =>
                _ethernetAddress = EthernetAddress.constructMulticastAddress() 
            case Some(_) =>
                _ethernetAddress = ethAddr
        }
        _ethernetAddress.getOrThrow().toByteArray(uuidBytes, 10)
        // and add clock sequence
        var clockSeq: Int32 = timer.getClockSequence()
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE)] = UInt8(clockSeq >> 8)
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE + 1)] = UInt8(clockSeq)
        var l2: Int64 = UUIDUtil.gatherLong(UInt8ToInt8(uuidBytes), 8)
        _uuidL2 = UUIDUtil.initUUIDSecondLong(l2)
        _timer = timer
    }