    private static func _toInt(buffer: Array<UInt8>, offset: Int64) {
         return (Int64(buffer[offset]) << 24)+ ((Int64(buffer[offset + 1]) & 0xFF) << 16)+ ((Int64(buffer[offset + 2]) & 0xFF) << 8)+ (Int64(buffer[offset + 3]) & 0xFF)
    }