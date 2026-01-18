    private static func hexVal(ch: Char): UInt32 {
        let lch = UInt32(ch) | 32
        return if (lch <= ORD_9) {
            lch - ORD_0
        } else {
            lch - ORD_a + 10
        }
        
    }