    public static func timeBasedGenerator(ethernetAddress: Option<EthernetAddress>):TimeBasedGenerator{
        return timeBasedGenerator(ethernetAddress, Option<UUIDTimer>.None)
    }