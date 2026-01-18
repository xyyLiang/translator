    private func ensureCache(count: Int64): Bool {
        while (bitsCachedSize < count && bitsCachedSize < 57) {
            let nextByte: Int64 = this.input.readOneByte()
            if (nextByte < 0) {
                return true
            }
            match (byteOrder) {
                case Endian.Little => bitsCachedValue |= (nextByte << bitsCachedSize)
                case _ =>
                    bitsCachedValue <<= 8
                    bitsCachedValue |= nextByte
            }

            bitsCachedSize += 8
        }
        return false
    }