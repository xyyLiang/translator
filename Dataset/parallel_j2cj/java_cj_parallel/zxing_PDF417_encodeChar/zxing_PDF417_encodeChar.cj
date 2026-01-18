    static func encodeChar(pattern: Int64, len: Int64, logic: BarcodeRow) {
        var map = 1 << len - 1
        var last = (pattern & map) != 0
        var width = 0
        for (i in 0..len) {
            let black = (pattern & map) != 0
            if (last == black) {
                width++
            } else {
                logic.addBar(last, width)

                last = black
                width = 1
            }
            map >>= 1
        }
        logic.addBar(last, width)
    }