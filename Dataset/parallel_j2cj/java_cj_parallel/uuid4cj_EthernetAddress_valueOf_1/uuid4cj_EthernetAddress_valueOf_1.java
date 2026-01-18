    public static EthernetAddress valueOf(int[] addr)
        throws NumberFormatException
    {
        byte[] bAddr = new byte[addr.length];

        for (int i = 0; i < addr.length; ++i) {
            bAddr[i] = (byte) addr[i];
        }
        return new EthernetAddress(bAddr);
    }