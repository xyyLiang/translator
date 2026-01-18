    public override func read(buffer: Array<Byte>): Int64 {
        if (this.bin.isNone()) {
            throw CompressorException("Stream closed")
        }
        for (i in 0..buffer.size) {
            let r: Int64 = read0()
            if (r < 0) {
                return i
            } else {
                buffer[i] = UInt8(r & 0xff)
                count(1)
            }
        }
        return buffer.size
    }