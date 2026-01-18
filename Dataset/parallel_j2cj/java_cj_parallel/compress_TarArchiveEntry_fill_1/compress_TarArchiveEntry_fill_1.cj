    func fill(value: Byte, offset: Int64, outbuf: Array<Byte>, length: Int64): Int64 {
        for (i in 0..length) {
            outbuf[offset + i] = value
        }
        return offset + length
    }