    static func isOnlyDoubleByteKanji(content: String): Bool {
        let bytes = content.toUtf8Array()
        let length = bytes.size
        if (length % 2 != 0) {
            return false
        }
        for (i in 0..length : 2) {
            let byte1 = Int64(bytes[i]) & 0xFF
            if ((byte1 < 0x81 || byte1 > 0x9F) && (byte1 < 0xE0 || byte1 > 0xEB)) {
                return false
            }
        }
        true
    }