    @OverflowWrapping
    public func toString(): String{
        var str = _asString
        if(let Some(i) <- str){
            return i
        }

        var b:StringBuilder = StringBuilder()
        var i1:Int32 = Int32(_address >> 32)
        var i2:Int32 = Int32(_address)

        _appendHex(b, Int64(i1 >> 8))
        b.append(':')
        _appendHex(b, Int64(i1))
        b.append(':')
        _appendHex(b, Int64(i2 >> 24))
        b.append(':')
        _appendHex(b, Int64(i2 >> 16))
        b.append(':')
        _appendHex(b, Int64(i2 >> 8))
        b.append(':')
        _appendHex(b, Int64(i2))
        _asString = b.toString()
        str = b.toString()
        return str.getOrThrow()
    }