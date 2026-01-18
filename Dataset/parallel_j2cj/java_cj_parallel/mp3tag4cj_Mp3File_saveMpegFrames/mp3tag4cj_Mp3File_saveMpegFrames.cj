    private func saveMpegFrames(saveFile: File): Unit {
        var filePos: Int32 = xingOffset
        if (filePos < 0) {
            filePos = startOffset
        }
        if (filePos < 0) {
            return
        }
        if (endOffset < filePos) {
            return
        }
        var byteBuffer: Array<UInt8> = Array<UInt8>(Int64(bufferLength), {_ => 0})
        try {
            var seekableByteChannel: File = File(super.path, OpenOption.Open(true, true))
            seekableByteChannel.seek(SeekPosition.Begin(Int64(filePos)))
            while (true) {
                var bytesRead: Int64 = seekableByteChannel.read(byteBuffer)
                if (Int64(filePos) + bytesRead <= Int64(endOffset)) {
                    saveFile.write(byteBuffer.slice(0, Int64(bytesRead)))
                    filePos += Int32(bytesRead)
                } else {
                    saveFile.write(byteBuffer.slice(0, Int64(endOffset - filePos + 1)))
                    break
                }
            }
        } catch (e: Exception) {}
    }