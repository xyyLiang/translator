    public static func constructMulticastAddress(rnd:SecureRandom):EthernetAddress{
        var dummy:Array<UInt8> =  Array<UInt8>(6,item:0)
        synchronized(m1){
            dummy = rnd.nextBytes(6)
        }
        dummy[0] |= UInt8(0x01)
        return EthernetAddress(dummy)
    }