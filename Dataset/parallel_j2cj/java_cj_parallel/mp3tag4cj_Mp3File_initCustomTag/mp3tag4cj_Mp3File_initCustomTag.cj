    private func initCustomTag(seekableByteChannel: File): Unit {
        var bufferLength: Int32 = (Int32(getLength()) - (endOffset + 1)) //文件长度 - 最后音频数据帧的结尾偏移量
        if (hasId3v1Tag()) {
            bufferLength -= ID3v1Tag.TAG_LENGTH
        } //包含ID3V1的时候 需要减去ID3V1标签的长度
        if (bufferLength <= 0) { //得到CusttomTag的长度
            customTag = Option<Array<Int8>>.None
        } else {
            var byteBuffer: Array<UInt8> = Array<UInt8>(Int64(bufferLength), {_ => 0})
            seekableByteChannel.seek(SeekPosition.Begin(Int64(endOffset) + 1)) //偏移量设置为，最后一个音频数据帧的结尾
            var bytesRead: Int64 = seekableByteChannel.read(byteBuffer) //读取整个CusttomTage的数据
            var bytes: Array<Int8> = BufferTools.transUInt8ArrayToInt8(byteBuffer)
            customTag = Option<Array<Int8>>.Some(bytes) //赋值给成员customTag
            if (bytesRead < Int64(bufferLength)) {
                throw Exception("Not enough bytes read")
            }
        }
    }