    private func readNextByte(input: BitInputStream): Int64 {
        return input.readBits(8)
    }