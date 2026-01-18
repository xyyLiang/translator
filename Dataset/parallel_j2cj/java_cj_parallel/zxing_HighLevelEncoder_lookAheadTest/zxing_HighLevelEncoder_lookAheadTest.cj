    static func lookAheadTest(msg: String, startPos: Int64, currentMode: Int64): Int64 {
        var newMode = lookAheadTestIntern(msg, startPos, currentMode)
        if (currentMode == X12_ENCODATION && newMode == X12_ENCODATION) {
            let endPos = math.min(startPos + 3, msg.size)
            for (i in startPos..endPos) {
                if (!isNativeX12(msg.charAt(i))) {
                    return ASCII_ENCODATION
                }
            }
        } else if (currentMode == EDIFACT_ENCODATION && newMode == EDIFACT_ENCODATION) {
            let endPos = math.min(startPos + 4, msg.size)
            for (i in startPos..endPos) {
                if (!isNativeEDIFACT(msg.charAt(i))) {
                    return ASCII_ENCODATION
                }
            }
        }
        newMode
    }