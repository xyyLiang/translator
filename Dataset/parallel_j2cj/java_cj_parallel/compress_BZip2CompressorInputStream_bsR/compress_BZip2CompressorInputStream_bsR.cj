    private static func bsR(bin: BitInputStream, n: Int64): Int64 {
        let thech = bin.readBits(n)
        if (thech < 0) {
            throw CompressorException("Unexpected end of stream")
        }

        //translate Int64 to UInt8
        return thech
    }