    public static func initUUIDFirstLong(l1: Int64, types: UUIDType): Int64 {
        return initUUIDFirstLong(l1, Int32(types.raw()))
    }
