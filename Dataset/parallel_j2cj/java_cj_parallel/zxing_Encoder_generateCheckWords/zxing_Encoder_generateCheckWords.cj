    static func generateCheckWords(bitArray: BitArray, totalBits: Int64, wordSize: Int64): BitArray {
        let messageSizeInWords = bitArray.size / wordSize
        let rs = ReedSolomonEncoder(getGF(wordSize))
        let totalWords = totalBits / wordSize
        let messageWords = bitsToWords(bitArray, wordSize, totalWords)
        rs.encode(messageWords, totalWords - messageSizeInWords)
        let startPad = totalBits % wordSize
        let messageBits = BitArray()
        messageBits.appendBits(0, startPad)
        for (messageWord in messageWords) {
            messageBits.appendBits(messageWord, wordSize)
        }
        return messageBits
    }