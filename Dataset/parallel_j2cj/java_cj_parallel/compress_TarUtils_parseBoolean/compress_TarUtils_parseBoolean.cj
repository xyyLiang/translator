    public static func parseBoolean(buffer: Array<Byte>, offset: Int64): Bool {
        return buffer[offset] == 1
    }