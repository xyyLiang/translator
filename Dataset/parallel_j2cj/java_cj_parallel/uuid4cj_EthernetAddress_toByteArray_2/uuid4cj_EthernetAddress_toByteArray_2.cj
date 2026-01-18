    @OverflowWrapping
    public func toByteArray(uuidBytesArray:Array<UInt8>,pos:Int64):Unit{
         if (pos < 0 || (pos + 6) > uuidBytesArray.size) {
            throw  IllegalArgumentException("Illegal offset (${pos}), need room for 6 bytes")
        }
        var temppos = pos
        var i:Int32 = Int32(_address >> 32)
        uuidBytesArray[temppos] = UInt8(i >> 8)
        temppos++
        uuidBytesArray[temppos] = UInt8(i)
        temppos++
        i = Int32(_address)
        uuidBytesArray[temppos] = UInt8(i >> 24)
        temppos++
        uuidBytesArray[temppos] = UInt8(i >> 16)
        temppos++
        uuidBytesArray[temppos] = UInt8(i >> 8)
        temppos++
        uuidBytesArray[temppos] = UInt8(i)
    }
