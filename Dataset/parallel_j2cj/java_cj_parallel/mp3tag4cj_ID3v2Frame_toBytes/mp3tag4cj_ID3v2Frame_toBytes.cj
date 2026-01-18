    public open func toBytes(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {_ => 0})
        packFrame(bytes, 0)
        return bytes
    }