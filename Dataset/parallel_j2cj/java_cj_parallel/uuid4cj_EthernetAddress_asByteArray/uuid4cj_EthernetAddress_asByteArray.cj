    public func asByteArray():Array<UInt8>{
        var result:Array<UInt8> = Array<UInt8>(6,item:0)
        toByteArray(result)
        return result
    }