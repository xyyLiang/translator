    public static TimeBasedGenerator timeBasedGenerator(EthernetAddress ethernetAddress,
            TimestampSynchronizer sync)
    {
        UUIDTimer timer;
        try {
            timer = new UUIDTimer(new Random(System.currentTimeMillis()), sync);
        } catch (IOException e) {
            throw new IllegalArgumentException("Failed to create UUIDTimer with specified synchronizer: "+e.getMessage(), e);
        }
        return timeBasedGenerator(ethernetAddress, timer);
    }