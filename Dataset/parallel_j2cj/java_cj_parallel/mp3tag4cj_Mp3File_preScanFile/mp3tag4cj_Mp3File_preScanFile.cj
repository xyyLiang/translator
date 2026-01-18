    protected func preScanFile(seekableByteChannel: File): Int32 {
        var byteBuffer: Array<UInt8> = Array<UInt8>(Int64(AbstractID3v2Tag.HEADER_LENGTH), {_ => 0})
        try {
            seekableByteChannel.seek(SeekPosition.Begin(0)) //将字节流的位置置为0
            var bytesRead: Int64 = seekableByteChannel.read(byteBuffer) //标签头的字节流 读入byteBuffer
            if (bytesRead == Int64(AbstractID3v2Tag.HEADER_LENGTH)) {
                try {
                    var bytes: Array<Int8> = BufferTools.transUInt8ArrayToInt8(byteBuffer)
                    ID3v2TagFactory.sanityCheckTag(bytes) //检查标签头合法
                    return AbstractID3v2Tag.HEADER_LENGTH + BufferTools.unpackSynchsafeInteger(
                        bytes[Int64(AbstractID3v2Tag.DATA_LENGTH_OFFSET)],
                        bytes[Int64(AbstractID3v2Tag.DATA_LENGTH_OFFSET) + 1],
                        bytes[Int64(AbstractID3v2Tag.DATA_LENGTH_OFFSET) + 2],
                        bytes[Int64(AbstractID3v2Tag.DATA_LENGTH_OFFSET) + 3]
                    )
                    //这里返回的是标签的总大小 为 标签头大小（10） +  标签帧的大小
                } catch (e: NoSuchTagException) {}
            }
        } catch (e: Exception) {}
        return 0
    }