    static func getMinCodewordWidth(p: Array<?ResultPoint>): Int64 {
        math.min(
            math.min(
                getMinWidth(p[0], p[4]),
                getMinWidth(p[6], p[2]) * PDF417Common.MODULES_IN_CODEWORD / PDF417Common.MODULES_IN_STOP_PATTERN
            ),
            math.min(
                getMinWidth(p[1], p[5]),
                getMinWidth(p[7], p[3]) * PDF417Common.MODULES_IN_CODEWORD / PDF417Common.MODULES_IN_STOP_PATTERN
            )
        )
    }