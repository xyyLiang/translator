    private func initId3v2Tag(seekableByteChannel: File): Unit {
        if (xingOffset == 0 || startOffset == 0) { //通过这两个条件判断是否包含ID3V2标签
            id3v2Tag = Option<ID3v2>.None
        } else {
            var bufferLength: Int32
            if (hasXingFrame()) {
                bufferLength = xingOffset
                //如果存在Xing-header 定义一个长度为xing-header开始偏移量的大小
            } else {
                bufferLength = startOffset
                //如果没有xing-header的话 定义一个长度为 第一个音频数据帧开始的偏移量的大小
            }
            var byteBuffer: Array<UInt8> = Array<UInt8>(Int64(bufferLength), {_ => 0})
            seekableByteChannel.seek(SeekPosition.Begin(0)) //偏移量置换为零
            var bytesRead: Int64 = seekableByteChannel.read(byteBuffer) //读取这样大小的buffer 即为 ID3V2标签的内容
            if (bytesRead < Int64(bufferLength)) {
                throw Exception("Not enough bytes read")
            }
            try {
                var bytes: Array<Int8> = BufferTools.transUInt8ArrayToInt8(byteBuffer)
                var iD3v2 = (ID3v2TagFactory.createTag(bytes).getOrThrow() as ID3v2).getOrThrow()
                this.id3v2Tag = Option<ID3v2>.Some(iD3v2) //传入整个标签的内容，创建标签赋值给变量
            } catch (e: Exception) {
                id3v2Tag = Option<ID3v2>.None
            }
        }
    }