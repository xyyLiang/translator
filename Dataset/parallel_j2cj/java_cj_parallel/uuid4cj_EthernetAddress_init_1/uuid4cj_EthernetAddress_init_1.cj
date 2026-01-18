    public init(addr : Array<UInt8>){
        if(addr.size != 6){
            throw  NumberFormatException("Ethernet address has to consist of 6 bytes")
        }
        var l:Int64 = Int64(addr[0] & 0xFF)
        for (i in 1..6) {
            l = (l << 8) | Int64(addr[i] & 0xFF)
        }
        _address = l
    }