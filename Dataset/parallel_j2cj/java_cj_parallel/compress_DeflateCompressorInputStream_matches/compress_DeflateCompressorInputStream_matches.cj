    public static func matches(sign: Array<Byte>, len: Int32): Bool {
        return len > 3 && (sign[0] == MAGIC_1 || sign[0] == 237) && (sign[1] == MAGIC_2a || sign[1] == MAGIC_2b || sign[1] == MAGIC_2c || sign[1] == MAGIC_2d || sign[1] == 212)
    }