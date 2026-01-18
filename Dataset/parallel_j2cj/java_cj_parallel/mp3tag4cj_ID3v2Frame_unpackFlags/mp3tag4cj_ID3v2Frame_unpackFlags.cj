    private func unpackFlags(buffer: Array<Int8>, offset: Int32): Unit {
        //解析标签帧的 帧头标记数据
        //给成员
        preserveTag = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS1_OFFSET)], Int64(PRESERVE_TAG_BIT))
        preserveFile = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS1_OFFSET)], Int64(PRESERVE_FILE_BIT))
        readOnly = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS1_OFFSET)], Int64(READ_ONLY_BIT))
        group = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS2_OFFSET)], Int64(GROUP_BIT))
        compression = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS2_OFFSET)], Int64(COMPRESSION_BIT))
        encryption = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS2_OFFSET)], Int64(ENCRYPTION_BIT))
        unsynchronisation = BufferTools.checkBit(
            buffer[Int64(offset) + Int64(FLAGS2_OFFSET)],
            Int64(UNSYNCHRONISATION_BIT)
        )
        dataLengthIndicator = BufferTools.checkBit(
            buffer[Int64(offset) + Int64(FLAGS2_OFFSET)],
            Int64(DATA_LENGTH_INDICATOR_BIT)
        )
    }