    public static func pack16bits(a: Int32, b: Int32): Int32 {
        return ((b << 16) | a)
    }