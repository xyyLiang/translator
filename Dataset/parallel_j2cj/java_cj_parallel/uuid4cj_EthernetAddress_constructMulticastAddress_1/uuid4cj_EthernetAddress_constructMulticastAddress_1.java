    public static EthernetAddress constructMulticastAddress(Random rnd)
    {
        byte[] dummy = new byte[6];
        synchronized (rnd) {
            rnd.nextBytes(dummy);
        }
        /* Need to set the broadcast bit to indicate it's not a real
         * address.
         */
        /* 20-May-2010, tatu: Actually, we could use both second least-sig-bit
         *   ("locally administered") or the LSB (multicast), as neither is
         *   ever set for 'real' addresses.
         *   Since UUID specs recommends latter, use that.
         */
        dummy[0] |= (byte) 0x01;
        return new EthernetAddress(dummy);
    }