    public static func pack4bits(a: Int32, b: Int32, c: Int32, d: Int32, e: Int32, f: Int32, g: Int32, h: Int32): Int32 {
        return pack8bits((b << 4) | a, (d << 4) | c, (f << 4) | e, (h << 4) | g)
    }