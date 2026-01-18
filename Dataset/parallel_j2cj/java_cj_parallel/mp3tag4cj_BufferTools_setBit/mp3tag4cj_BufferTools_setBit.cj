    @OverflowWrapping
    public static func setBit(b: Int8, bitPosition: Int64, value: Bool): Int8 {
        var newByte: Int8
        if (value) {
            newByte = Int8(b | (0x01 << bitPosition))
        } else {
            newByte = Int8((b & (!(0x01 << bitPosition))))
        }
        return newByte
    }