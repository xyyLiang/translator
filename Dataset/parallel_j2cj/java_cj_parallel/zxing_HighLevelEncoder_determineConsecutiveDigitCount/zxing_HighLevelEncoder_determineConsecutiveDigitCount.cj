    static func determineConsecutiveDigitCount(msg: String, startPos: Int64): Int64 {
        let len = msg.size
        var idx = startPos
        while (idx < len && isDigit(msg.charAt(idx))) {
            idx++
        }
        idx - startPos
    }