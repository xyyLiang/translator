    public func packFrameData(): Array<Int8> {
        var bb: ByteBuffer = ByteBuffer.allocate(Int64(getLength()))
        bb.put(id.getOrDefault({ => ""}).toArray())
        bb.put(UInt8(0))
        bb.put(UInt8(getFlags()))
        bb.put(UInt8(children.getOrThrow().size))

        for (child in children.getOrThrow()) {
            bb.put(child.toArray())
            bb.put(UInt8(0))
        }

        for (frame in subframes.getOrThrow()) {
            try {
                bb.put(BufferTools.transInt8ArrayToUInt8(frame.toBytes()))
            } catch (e: Exception) {

            }
        }
        return BufferTools.transUInt8ArrayToInt8(bb.array())
    }