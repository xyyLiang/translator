    public func toByteArray(array:Array<UInt8>):Unit{
        if (array.size < 6) {
            throw IllegalArgumentException("Too small array, need to have space for 6 bytes")
        }
        toByteArray(array, 0)
    }