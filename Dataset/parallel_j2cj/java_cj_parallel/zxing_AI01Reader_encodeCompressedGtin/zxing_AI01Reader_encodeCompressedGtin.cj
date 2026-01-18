    func encodeCompressedGtin(buf: StringBuilder, currentPos: Int64) {
        buf.append("(01)")
        let initialPosition = buf.size
        buf.append('9')

        encodeCompressedGtinWithoutAI(buf, currentPos, initialPosition)
    }