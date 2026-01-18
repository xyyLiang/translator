    public static func timeBasedReorderedGenerator(ethernetAddress: EthernetAddress): TimeBasedReorderedGenerator{
        return TimeBasedReorderedGenerator(ethernetAddress, sharedTimer().getOrThrow())
    }