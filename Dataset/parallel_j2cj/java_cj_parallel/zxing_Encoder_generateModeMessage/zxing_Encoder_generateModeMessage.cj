    static func generateModeMessage(compact: Bool, layers: Int64, messageSizeInWords: Int64): BitArray {
        var modeMessage = BitArray()
        if (compact) {
            modeMessage.appendBits(layers - 1, 2)
            modeMessage.appendBits(messageSizeInWords - 1, 6)
            modeMessage = generateCheckWords(modeMessage, 28, 4)
        } else {
            modeMessage.appendBits(layers - 1, 5)
            modeMessage.appendBits(messageSizeInWords - 1, 11)
            modeMessage = generateCheckWords(modeMessage, 40, 4)
        }
        modeMessage
    }