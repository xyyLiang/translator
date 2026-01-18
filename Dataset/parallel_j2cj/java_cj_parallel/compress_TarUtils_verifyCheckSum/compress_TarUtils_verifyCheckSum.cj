    public static func verifyCheckSum(header: Array<Byte>): Bool {
        let storedSum: Int64 = parseOctal(header, TarConstants.CHKSUM_OFFSET, TarConstants.CHKSUMLEN)
        var unsignedSum: Int64 = 0
        var signedSum: Int64 = 0
        for (i in 0..header.size) {
            var b = header[i]
            if (TarConstants.CHKSUM_OFFSET <= i && i < TarConstants.CHKSUM_OFFSET + TarConstants.CHKSUMLEN) {
                b = UInt8(UInt32(' '))
            }
            unsignedSum += Int64(0xff & b)
            signedSum += Int64(b)
        }
        return storedSum == unsignedSum || storedSum == signedSum
    }