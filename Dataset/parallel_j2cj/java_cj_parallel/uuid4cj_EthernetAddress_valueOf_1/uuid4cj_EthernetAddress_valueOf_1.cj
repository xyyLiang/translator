    @OverflowWrapping 
    public static func valueOf(addr:Array<Int32>):EthernetAddress{
        var bAddr:Array<UInt8> = Array<UInt8>(addr.size,item:0)
        for (i in 0..addr.size) {
            bAddr[i] = UInt8(addr[i])
        }
        return EthernetAddress(bAddr)
    }