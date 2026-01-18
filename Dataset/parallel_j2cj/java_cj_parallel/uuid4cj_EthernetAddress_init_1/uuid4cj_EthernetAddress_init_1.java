    public EthernetAddress(byte [] addr)
        throws NumberFormatException
    {
        if (addr.length != 6) {
            throw new NumberFormatException("Ethernet address has to consist of 6 bytes");
        }
        long l = addr[0] & 0xFF;
        for (int i = 1; i < 6; ++i) {
            l = (l << 8) | (addr[i] & 0xFF); 
        }
        _address = l;
    }