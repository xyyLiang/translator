    static func getAlphanumericCode(code: Int64): Int64 {
        if (code < ALPHANUMERIC_TABLE.size) {
            ALPHANUMERIC_TABLE[code]
        } else {
            -1
        }
    }
