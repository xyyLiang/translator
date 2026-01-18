    public static func matches(signature: Array<UInt8>, length: Int64): Bool {
        // 'B' 'Z' 'h'
        return length >= 3 && signature[0] == 0x42 && signature[1] == 0x5a && signature[2] == 0x68
    }