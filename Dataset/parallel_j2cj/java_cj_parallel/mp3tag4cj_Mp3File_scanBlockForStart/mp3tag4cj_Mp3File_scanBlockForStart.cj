    @OverflowWrapping
    private func scanBlockForStart(bytes: Array<Int8>, bytesRead: Int32, absoluteOffset: Int32, offsets: Int32): Int32 {
        var offset: Int32 = offsets

        //循环可以得到音频数据帧的个数，不包括Xing-header帧
        while (offset < (bytesRead - MINIMUM_BUFFER_LENGTH)) {
            if (bytes[Int64(offset)] == Int8(0xFF) && (bytes[Int64(offset) + 1] & Int8(0xE0)) == Int8(0xE0)) {
                //对此块检查是否是帧同步镖旗
                try {
                    //构建媒体对象， 将此块的前4个字节拿到，也就是 数据帧头， 通过次块的帧头（每个音频数据帧的前4个字节）将许局封装进媒体对象
                    var frame: MpegFrame = MpegFrame(
                        bytes[Int64(offset)],
                        bytes[Int64(offset) + 1],
                        bytes[Int64(offset) + 2],
                        bytes[Int64(offset) + 3]
                    )

                    //判断Xing-header偏移量，和此帧是否是Xing-header帧
                    if (this.xingOffset < 0 && isXingFrame(bytes, offset)) {
                        this.xingOffset = absoluteOffset + offset

                        //设置xingOffset首次的值为 文件偏移量（标签末尾偏移量） + 0
                        this.xingBitrate = frame.getBitrate()
                        offset += frame.getLengthInBytes()
                    } else {
                        this.startOffset = absoluteOffset + offset
                        this.channelMode = frame.getChannelMode()
                        this.emphasis = frame.getEmphasis()
                        this.layer = frame.getLayer()
                        this.modeExtension = frame.getModeExtension()
                        this.sampleRate = frame.getSampleRate()
                        this.version = frame.getVersion()
                        this.copyright = frame.isCopyright()
                        this.original = frame.isOriginal()
                        frameCounts++

                        //存储每一个音频数据真的位率
                        addBitrates(frame.getBitrate())
                        offset += frame.getLengthInBytes()
                        return offset
                    }
                } catch (e: InvalidDataException) {
                    offset++
                }
            } else {
                offset++
            }
        }
        return offset
    }