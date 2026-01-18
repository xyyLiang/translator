    public static TimeBasedGenerator timeBasedGenerator(EthernetAddress ethernetAddress,
            UUIDTimer timer)
    {
        if (timer == null) {
            timer = sharedTimer();
        }
        return new TimeBasedGenerator(ethernetAddress, timer);
    }