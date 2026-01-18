    public func isMulticastAddress():Bool{
        return ((Int32(_address >> 40)) & 0x01) != 0
    }