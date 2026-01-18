    public static func timeBasedGenerator(ethernetAddress: Option<EthernetAddress>, timer: Option<UUIDTimer>):TimeBasedGenerator{
        let timerTT = match (timer) {
            case Some(_) => timer
            case None => sharedTimer()
        }
        return  TimeBasedGenerator(ethernetAddress, timerTT.getOrThrow());
    }