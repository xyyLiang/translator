    /**
     * Another binary constructor; constructs an instance from the given
     * long argument; the lowest 6 bytes contain the address.
     *
     * @param addr long that contains the MAC address in 6 least significant
     *    bytes.
     */
    public EthernetAddress(long addr) {
        _address = addr;
    }