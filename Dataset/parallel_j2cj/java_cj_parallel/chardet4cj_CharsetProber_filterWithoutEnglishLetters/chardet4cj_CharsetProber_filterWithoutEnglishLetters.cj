    public func filterWithoutEnglishLetters(buf: Array<Byte>, offset: Int32, length: Int32): ByteBuffer {
        if (buf.size == 0) {
            throw ChardetException("this buf is empty")
        }
        var out: ByteBuffer = ByteBuffer.allocate(Int64(length))

        var meetMSB: Bool = false
        var c: Byte = 0

        var prevPtr: Int32 = offset
        var curPtr: Int32 = offset
        var maxPtr: Int32 = offset + length
        if (maxPtr <= 0) {
            throw ChardetException("this length is null")
        }
        for (_ in curPtr..maxPtr) {
            c = buf[Int64(curPtr)]
            if (!isAscii(c)) {
                meetMSB = true
            } else if (isAsciiSymbol(c)) {

                if (meetMSB && curPtr > prevPtr) {
                    // this segment contains more than single symbol,
                    // and it has upper ASCII, we need to keep it
                    out.put(buf, Int64(prevPtr), Int64(curPtr-prevPtr))
                    out.put(UInt8(ASCII_SP))
                    prevPtr = curPtr + 1
                    meetMSB = false
                } else {
                    prevPtr = curPtr + 1
                }

            }
            curPtr++
        }

        if (meetMSB && curPtr > prevPtr) {
            out.put(buf, Int64(prevPtr), Int64(curPtr-prevPtr))
        }
        return out
    }