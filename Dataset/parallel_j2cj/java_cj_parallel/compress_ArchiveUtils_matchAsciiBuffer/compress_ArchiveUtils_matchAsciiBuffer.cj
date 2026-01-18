    public static func matchAsciiBuffer(expected: String, buffer: Array<Byte>, offset!: Int64 = 0, length!: Int64 = 0): Bool {
        let buffer1: Array<Byte> = Array<Byte>(expected.size, item: 0)
        for (i in 0..expected.size) {
            buffer1[i] = UInt8(UInt32(expected[i]))
        }
        return isEqual(buffer1, 0, buffer1.size, buffer, offset, length, false)
    }