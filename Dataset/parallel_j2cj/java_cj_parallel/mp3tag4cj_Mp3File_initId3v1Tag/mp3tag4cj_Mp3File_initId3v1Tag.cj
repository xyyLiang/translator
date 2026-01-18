    private func initId3v1Tag(file: File): Unit {
        var byteBuffer: Array<Byte> = Array<Byte>(Int64(ID3v1Tag.TAG_LENGTH), {_ => 0})
        var byteBuffer2: Array<Byte> = Array<Byte>(getLength(), {_ => 0})
        file.read(byteBuffer2)
        file.seek(SeekPosition.Begin(getLength() - Int64(ID3v1Tag.TAG_LENGTH)))
        var bytesRead: Int64 = file.read(byteBuffer)
        if (bytesRead < Int64(ID3v1Tag.TAG_LENGTH)) {
            throw BaseException("Not enough bytes read")
        }
        try {
            this.id3v1Tag = Option<ID3v1>.Some(ID3v1Tag(byteBuffer))
        } catch (e: Exception) {
            this.id3v1Tag = Option<ID3v1>.None
        }
    }