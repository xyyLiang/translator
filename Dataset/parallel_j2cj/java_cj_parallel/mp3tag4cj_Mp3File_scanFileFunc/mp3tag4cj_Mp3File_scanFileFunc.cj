    private func scanFileFunc(seekableByteChannel: File): Unit {
        var byteBuffer: Array<UInt8> = Array<UInt8>(Int64(this.bufferLength), {_ => 0})
        var fileOffset: Int32 = preScanFile(seekableByteChannel)
        seekableByteChannel.seek(SeekPosition.Begin(Int64(fileOffset)))
        var lastBlock: Bool = false
        var lastOffset: Int32 = fileOffset
        while (!lastBlock) {
            var bytesRead: Int64 = seekableByteChannel.read(byteBuffer)
            var bytes: Array<Int8> = BufferTools.transUInt8ArrayToInt8(byteBuffer)
            if (bytesRead < Int64(bufferLength)) {
                lastBlock = true
            }
            if (bytesRead >= Int64(MINIMUM_BUFFER_LENGTH)) {
                while (true) {
                    try {
                        var offset: Int32 = 0 // 1设置偏移量为0
                        if (this.startOffset < 0) { // 1成员startOffset初始值为-1
                            offset = scanBlockForStart(bytes, Int32(bytesRead), fileOffset, offset)
                            if (this.startOffset >= 0 && !scanFile) {
                                return
                            }
                            lastOffset = startOffset
                        }
                        offset = scanBlock(bytes, Int32(bytesRead), fileOffset, offset)
                        fileOffset += offset
                        seekableByteChannel.seek(SeekPosition.Begin(Int64(fileOffset)))
                        break
                    } catch (e: Exception) {
                        if (frameCounts < 2) {
                            xingOffset = -1
                            frameCounts = 0
                            startOffset = -1
                            bitrates.clear()
                            lastBlock = false
                            fileOffset = 1 + lastOffset
                            if (fileOffset == 0) {
                                throw InvalidDataException("Valid start of mpeg frames not found ${e}")
                            }
                            seekableByteChannel.seek(SeekPosition.Begin(Int64(fileOffset)))
                            break
                        }
                        return
                    }
                }
            }
        }
    }