    static func extensionChecksum(s: String): Int64 {
        let length = s.size
        var sum = 0
        for (i in (length - 2)..=0 : -2) {
            sum += Int64(UInt32(s.charAt(i))) - Int64(UInt32('0'))
        }
        sum *= 3
        for (i in (length - 1)..=0 : -2) {
            sum += Int64(UInt32(s.charAt(i))) - Int64(UInt32('0'))
        }
        sum *= 3
        sum % 10
    }