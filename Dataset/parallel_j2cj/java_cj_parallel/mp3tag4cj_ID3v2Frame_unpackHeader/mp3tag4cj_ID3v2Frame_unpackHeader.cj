    protected open func unpackHeader(buffer: Array<Int8>, offset: Int32): Int32 {
        //标签帧前4个字符 代表标签帧的标识
        //给成员id赋值
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(
            buffer,
            offset + ID_OFFSET,
            ID_LENGTH
        )) {
            case Some(x) => id = x
            case None => ()
        }
        unpackDataLength(buffer, offset) //计算标签帧 长度， 不包含 帧头的10个字节
        unpackFlags(buffer, offset) // 接续数据帧头中的标志，位置在帧头的9字节 和 10字节
        return offset + HEADER_LENGTH
    }