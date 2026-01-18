    public static func pack8bits(a: Int32, b: Int32, c: Int32, d: Int32): Int32 {
        return pack16bits((b << 8) | a, (d << 8) | c)
    }