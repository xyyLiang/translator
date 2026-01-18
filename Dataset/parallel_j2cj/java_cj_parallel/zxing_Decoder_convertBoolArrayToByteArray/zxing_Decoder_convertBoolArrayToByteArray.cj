    static func convertBoolArrayToByteArray(boolArr: Array<Bool>): Array<UInt8> {
        Array<UInt8>((boolArr.size + 7) / 8, {
                n => readByte(boolArr, 8 * n)
            })
    }