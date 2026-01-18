    private static func checkUUIDByteArray(bytes: Array<Int8>, offset: Int32): Unit {
        if (bytes.size == 0) {
            throw IllegalArgumentException("Invalid bytes passed: can not be null")
        }
        if (offset < 0) {
            throw IllegalArgumentException("Invalid offset (${offset}) passed: can not be negative")
        }
        if ((offset + 16) > Int32(bytes.size)) {
            throw IllegalArgumentException("Invalid offset (${offset}) passed: not enough room in byte array (need 16 bytes)")
        }
    }   