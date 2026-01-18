    static func appendNumericBytes(content: String, bits: BitArray) {
        let length = content.size
        var i = 0
        let zero = UInt32('0')
        while (i < length) {
            let num1 = UInt32(content.charAt(i)) - zero
            if (i + 2 < length) {
                let num2 = UInt32(content.charAt(i + 1)) - zero
                let num3 = UInt32(content.charAt(i + 2)) - zero
                bits.appendBits(Int64(num1 * 100 + num2 * 10 + num3), 10)
                i += 3
            } else if (i + 1 < length) {
                let num2 = UInt32(content.charAt(i + 1)) - zero
                bits.appendBits(Int64(num1 * 10 + num2), 7)
                i += 2
            } else {
                bits.appendBits(Int64(num1), 4)
                i++
            }
        }
    }