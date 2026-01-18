    public func read(buf: Array<Byte>, off: Int32, len: Int64): Int64 {
        var readNum = inp.getOrThrow().read(buf[Int64(off)..Int64(off) + len])
        return readNum
    }