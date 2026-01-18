    public static func timeBasedReorderedGenerator(): TimeBasedReorderedGenerator {
        return TimeBasedReorderedGenerator(Option<EthernetAddress>.None, sharedTimer().getOrThrow())
    }