    static func subBytes(input: ECIInput, start: Int64, end: Int64): Array<UInt8> {
        let count = end - start
        Array<UInt8>(count, {
                n => UInt8(UInt32(input.charAt(n + start)) & 0xFF)
            })
    }