    @OverflowWrapping
    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        var bb: ByteBuffer = ByteBuffer.wrap(BufferTools.transInt8ArrayToUInt8(bytes))
        id = Option<String>.Some(ByteBufferUtils.extractNullTerminatedString(bb))
        bb.position(id.getOrDefault({ => ""}).size + 1)
        startTime |= (Int32(bb.get()) << 24)
        startTime |= (Int32(bb.get()) << 16)
        startTime |= (Int32(bb.get()) << 8)
        startTime |= (Int32(bb.get()))
        endTime |= (Int32(bb.get()) << 24)
        endTime |= (Int32(bb.get()) << 16)
        endTime |= (Int32(bb.get()) << 8)
        endTime |= (Int32(bb.get()))
        startOffset |= (Int32(bb.get()) << 24)
        startOffset |= (Int32(bb.get()) << 16)
        startOffset |= (Int32(bb.get()) << 8)
        startOffset |= (Int32(bb.get()))
        endOffset |= (Int32(bb.get()) << 24)
        endOffset |= (Int32(bb.get()) << 16)
        endOffset |= (Int32(bb.get()) << 8)
        endOffset |= (Int32(bb.get()))
        var offset: Int64 = bb.position()
        while (offset < bytes.size) {
            var frame: ID3v2Frame = ID3v2Frame(bytes, Int32(offset))
            frame.unpackFrame(bytes, Int32(offset))
            offset += Int64(frame.getLength())
            subframes.getOrDefault({ => ArrayList<ID3v2Frame>()}).append(frame)
        }
    }
