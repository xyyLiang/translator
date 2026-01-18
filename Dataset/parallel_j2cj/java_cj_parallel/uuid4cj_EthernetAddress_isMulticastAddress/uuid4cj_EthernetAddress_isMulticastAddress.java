    public boolean isMulticastAddress() {
        return (((int) (_address >> 40)) & 0x01) != 0;
    }