    @OverflowWrapping
    public init(ethAddr:Option<EthernetAddress>,timer: UUIDTimer){
        var uuidBytes: Array<UInt8> = Array<UInt8>(16,item:0)
        var ethAddrTemp = ethAddr
        if (ethAddr == None) {
            ethAddrTemp = EthernetAddress.constructMulticastAddress()
        }
        _ethernetAddress = ethAddrTemp
        _ethernetAddress.getOrThrow().toByteArray(uuidBytes, 10)

        let clockSeq:Int32 = timer.getClockSequence()
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE)] = UInt8(clockSeq >> 8)
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE+1)] = UInt8(clockSeq)
        
        let l2: Int64 = UUIDUtil.gatherLong(UInt8ToInt8(uuidBytes), 8)

        _uuidL2 = UUIDUtil.initUUIDSecondLong(l2)
        _timer = timer
    }