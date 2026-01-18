    static func getStandardUPCEANChecksum(s: String): Int64 {
        let length = s.size
        var sum = 0
        for (i in (length - 1)..=0 : -2) {
            let digit = Int64(UInt32(s.charAt(i))) - Int64(UInt32('0'))
            if (digit < 0 || digit > 9) {
                throw FormatException()
            }
            sum += digit
        }
        sum *= 3
        for (i in (length - 2)..=0 : -2) {
            let digit = Int64(UInt32(s.charAt(i))) - Int64(UInt32('0'))
            if (digit < 0 || digit > 9) {
                throw FormatException()
            }
            sum += digit
        }
        (1000 - sum) % 10
    }