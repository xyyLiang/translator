    public static func timeBasedGenerator(ethernetAddress: Option<EthernetAddress>, sync: Option<FileBasedTimestampSynchronizer>):TimeBasedGenerator{
        var timer: UUIDTimer

        try {
            timer = UUIDTimer(SecureRandom(), sync)
        } catch (e: FSException | IllegalArgumentException) {
            throw InterruptedException("Failed to create UUIDTimer with specified synchronizer: " + e.toString())
        }
        
        return  timeBasedGenerator(ethernetAddress, timer);
    }