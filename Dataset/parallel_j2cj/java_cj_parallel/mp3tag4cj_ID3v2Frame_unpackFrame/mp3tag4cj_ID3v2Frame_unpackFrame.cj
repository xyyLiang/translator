    public open func unpackFrame(buffer: Array<Int8>, offset: Int32): Unit {
        var dataOffset: Int32 = unpackHeader(buffer, offset) //解析标签帧，帧头数据
        sanityCheckUnpackedHeader() //检查标签帧 帧头标志的合法性
        data = BufferTools.copyBuffer(buffer, Int64(dataOffset), Int64(dataLength))
    }