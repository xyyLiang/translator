    @OverflowWrapping
    public  func packFrameData(): Array<Int8> {
        var bb: ByteBuffer = ByteBuffer.allocate(Int64(getLength()))
        bb.put(id.getOrDefault({ => ""}).toArray())
        bb.put(UInt8(0))

        bb.put(UInt8((startTime & Int32(0xFF000000)) >> 24))
        bb.put(UInt8((startTime & 0x00FF0000) >> 16))
        bb.put(UInt8((startTime & 0x0000FF00) >> 8))
        bb.put(UInt8(startTime & 0x000000FF))

        bb.put(UInt8((endTime & Int32(0xFF000000)) >> 24))
        bb.put(UInt8((endTime & 0x00FF0000) >> 16))
        bb.put(UInt8((endTime & 0x0000FF00) >> 8))
        bb.put(UInt8(endTime & 0x000000FF))

        bb.put(UInt8((startOffset & Int32(0xFF000000)) >> 24))
        bb.put(UInt8((startOffset & 0x00FF0000) >> 16))
        bb.put(UInt8((startOffset & 0x0000FF00) >> 8))
        bb.put(UInt8(startOffset & 0x000000FF))

        bb.put(UInt8((endOffset & Int32(0xFF000000)) >> 24))
        bb.put(UInt8((endOffset & 0x00FF0000) >> 16))
        bb.put(UInt8((endOffset & 0x0000FF00) >> 8))
        bb.put(UInt8(endOffset & 0x000000FF))
        for (frame in subframes.getOrDefault({ => ArrayList<ID3v2Frame>()})) {
            try {
                bb.put(BufferTools.transInt8ArrayToUInt8(frame.toBytes()))
            } catch (e: Exception) {

            }
        }
        return BufferTools.transUInt8ArrayToInt8(bb.array())
    }
