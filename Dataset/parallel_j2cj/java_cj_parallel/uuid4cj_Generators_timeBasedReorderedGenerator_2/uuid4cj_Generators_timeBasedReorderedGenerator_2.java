    public static TimeBasedReorderedGenerator timeBasedReorderedGenerator(EthernetAddress ethernetAddress,
            UUIDTimer timer)
    {
        if (timer == null) {
            timer = sharedTimer();
        }
        return new TimeBasedReorderedGenerator(ethernetAddress, timer);
    }