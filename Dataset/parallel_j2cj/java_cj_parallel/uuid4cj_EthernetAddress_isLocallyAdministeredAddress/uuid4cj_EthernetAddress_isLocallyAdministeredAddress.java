    public boolean isLocallyAdministeredAddress() {
        return (((int) (_address >> 40)) & 0x02) != 0;
    }