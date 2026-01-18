    @OverflowWrapping
    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        var bb: ByteBuffer = ByteBuffer.wrap(BufferTools.transInt8ArrayToUInt8(bytes))

        id = Option<String>.Some(ByteBufferUtils.extractNullTerminatedString(bb))

        var flags: Int8 = Int8(bb.get())
        if ((flags & 0x01) == 0x01) {
            isRoots = true
        }
        if ((flags & 0x02) == 0x02) {
            isOrdereds = true
        }

        var childCount: Int32 = Int32(bb.get()) // TODO: 0xFF -> int = 255; byte = -128;

        children = Option<Array<String>>.Some(Array<String>(Int64(childCount), {_ => ""}))

        for (i in 0..childCount) {
            children.getOrThrow()[Int64(i)] = ByteBufferUtils.extractNullTerminatedString(bb)
        }

        var offset: Int64 = bb.position()
        while (offset < bytes.size) {
            var frameSrc: ID3v2Frame = ID3v2Frame(bytes, Int32(offset))
            frameSrc.unpackFrame(bytes, Int32(offset))
            offset += Int64(frameSrc.getLength())
            subframes.getOrDefault({ => ArrayList<ID3v2Frame>()}).append(frameSrc)
        }
    }
