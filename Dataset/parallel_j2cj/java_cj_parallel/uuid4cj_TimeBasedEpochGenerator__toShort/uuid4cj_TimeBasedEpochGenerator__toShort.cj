    private static func _toShort(buffer: Array<UInt8>, offset: Int64){
         return ((Int64(buffer[offset]) & 0xFF) << 8) + (Int64(buffer[offset + 1]) & 0xFF)
    }