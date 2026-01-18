    static func getMaxCodewordWidth(p: Array<?ResultPoint>): Int64 {
        math.max(
            math.max(
                getMaxWidth(p[0], p[4]),
                getMaxWidth(p[6], p[2]) * PDF417Common.MODULES_IN_CODEWORD / PDF417Common.MODULES_IN_STOP_PATTERN
            ),
            math.max(
                getMaxWidth(p[1], p[5]),
                getMaxWidth(p[7], p[3]) * PDF417Common.MODULES_IN_CODEWORD / PDF417Common.MODULES_IN_STOP_PATTERN
            )
        )
    }
