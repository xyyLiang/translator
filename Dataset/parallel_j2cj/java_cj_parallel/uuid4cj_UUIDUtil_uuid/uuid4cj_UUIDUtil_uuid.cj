    public static func uuid(id: String): UUID {
        if (id.size != 36) {
            throw NumberFormatException("UUID has to be represented by the standard 36-char representation")
        }

        var lo: Int64 = 0
        var hi: Int64 = 0
        var i: Int64 = 0
        var j: Int64 = 0
        for (_ in 0..36) {
            if( i >= 36 ) {
                break
            }
            // Need to bypass hyphens:
            if( i == 8 || i == 13 || i == 18 || i == 23) {
                if (id.toRuneArray()[i] != '-') {
                        throw NumberFormatException("UUID has to be represented by the standard 36-char representation")
                    }
                i++
            }

            var curr: Int32 = 0
            var c: Char = id.toRuneArray()[i]

            if (c >= '0' && c <= '9') {
                curr = Int32(UInt32(c) - UInt32('0'))
            } else if (c >= 'a' && c <= 'f') {
                curr = Int32(UInt32(c) - UInt32('a') + 10)
            } else if (c >= 'A' && c <= 'F') {
                curr = Int32(UInt32(c) - UInt32('A') + 10)
            } else {
                throw NumberFormatException("Non-hex character at #${i}: '${c}' (value ${UInt32(c).format("0x")})")
            }
            curr = (curr << 4)
            i++
            c = id.toRuneArray()[i]

            if (c >= '0' && c <= '9') {
                curr |= Int32(UInt32(c) - UInt32('0'))
            } else if (c >= 'a' && c <= 'f') {
                curr |= Int32(UInt32(c) - UInt32('a') + 10)
            } else if (c >= 'A' && c <= 'F') {
                curr |= Int32(UInt32(c) - UInt32('A') + 10)
            } else {
                throw NumberFormatException("Non-hex character at #${i}: '${c}' (value ${UInt32(c).format("0x")})")
            }
            if (j < 8) {
             hi = (hi << 8) | Int64(curr)
            } else {
             lo = (lo << 8) | Int64(curr)
            }
            j++
            i++
        }  
        let byteArrays: Array<UInt8> = Int8ToUInt8(int64asByteArray(hi, lo))
        return UUID(byteArrays)
    }