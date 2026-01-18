    private static func hexToBinary(b1: UInt8, b2: UInt8): UInt8 {
        var arr = Array<UInt8>([b1, b2])
        var sString = ""
        unsafe{
            sString = String.fromUtf8Unchecked(arr)
        }
        var opArr: Option<Array<UInt8>> = fromHexString(sString)
        var arr2: Array<UInt8> = match (opArr) {
            case Some(s) => s
            case None => Array<UInt8>()
        }
        if (arr2.size != 1) {
            throw QDecoderException("HexToBinary fail")
        }
        return arr2[0]
    }