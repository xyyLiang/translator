    public override func write(buffer: Array<Byte>): Unit {
        if (closed) {
            throw CompressorException("Stream closed")
        }
        for (b in buffer) {
            write0(b)
        }
    }