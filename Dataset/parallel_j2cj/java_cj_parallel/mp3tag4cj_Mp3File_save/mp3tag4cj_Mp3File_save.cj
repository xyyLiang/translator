    public func save(newFilename: String): Unit {
        var isExist: Bool = true
        try {
            FileInfo(newFilename).path.toCanonical().toString()
            ()
        } catch (e: Exception) {
            isExist = false
            ()
        }
        if (isExist) {
            if (FileInfo(newFilename).path.toCanonical().toString() == super.path) {
                throw IllegalArgumentException("Save filename same as source filename")
            }
        }
        var saveFile: File = File(newFilename, OpenOption.CreateOrTruncate(true))
        if (hasId3v2Tag()) {
            var bytes: Array<Int8> = this.id3v2Tag.getOrThrow().toBytes()
            var byteBuffer: Array<UInt8> = BufferTools.transInt8ArrayToUInt8(bytes)
            saveFile.write(byteBuffer)
        }
        saveMpegFrames(saveFile);
        if (hasCustomTag()) {
            var byteBuffer: Array<UInt8> = BufferTools.transInt8ArrayToUInt8(customTag.getOrThrow())
            saveFile.write(byteBuffer)
        }
        if (hasId3v1Tag()) {
            var bytes: Array<Int8> = this.id3v1Tag.getOrThrow().toBytes()
            var byteBuffer: Array<UInt8> = BufferTools.transInt8ArrayToUInt8(bytes)
            saveFile.write(byteBuffer)
        }
        saveFile.close()
    }