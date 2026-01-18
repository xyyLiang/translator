    static func checkStandardUPCEANChecksum(s: String): Bool {
        let length = s.size
        if (length == 0) {
            return false
        }
        let check = charDigit(s.charAt(length - 1), 10)
        getStandardUPCEANChecksum(s[0..(length - 1)]) == check
    }