    @overflowWrapping
    static func generateECBytes(dataBytes: Array<Int8>, numEcBytesInBlock: Int64): Array<Int8> {
        let numDataBytes = dataBytes.size
        let toEncode = Array<Int64>(
            numDataBytes + numEcBytesInBlock,
            {
                n => if (n < numDataBytes) {
                    Int64(dataBytes[n]) & 0xFF
                } else {
                    0
                }
            }
        )
        ReedSolomonEncoder(GenericGF.QR_CODE_FIELD_256).encode(toEncode, numEcBytesInBlock)

        let ecBytes = Array<Int8>(numEcBytesInBlock, item: 0)
        for (i in 0..numEcBytesInBlock) {
            ecBytes[i] = Int8(toEncode[numDataBytes + i])
        }
        ecBytes
    }