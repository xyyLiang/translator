    public func isLocallyAdministeredAddress():Bool{
        return ((Int32(_address >> 40)) & 0x02) != 0
    }