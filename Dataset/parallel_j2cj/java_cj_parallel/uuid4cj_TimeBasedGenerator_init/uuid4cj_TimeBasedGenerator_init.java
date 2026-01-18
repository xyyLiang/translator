    public TimeBasedGenerator(EthernetAddress ethAddr, UUIDTimer timer)
    {
        byte[] uuidBytes = new byte[16];
        if (ethAddr == null) {
            ethAddr = EthernetAddress.constructMulticastAddress();
        }
        // initialize baseline with MAC address info
        _ethernetAddress = ethAddr;
        _ethernetAddress.toByteArray(uuidBytes, 10);
        // and add clock sequence
        int clockSeq = timer.getClockSequence();
        uuidBytes[UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE] = (byte) (clockSeq >> 8);
        uuidBytes[UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE+1] = (byte) clockSeq;
        long l2 = UUIDUtil.gatherLong(uuidBytes, 8);
        _uuidL2 = UUIDUtil.initUUIDSecondLong(l2);
        _timer = timer;
    }