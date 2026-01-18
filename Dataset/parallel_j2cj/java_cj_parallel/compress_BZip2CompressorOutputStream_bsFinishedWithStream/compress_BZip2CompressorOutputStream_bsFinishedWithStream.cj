    private func bsFinishedWithStream(): Unit {
        while (this.bsLive > 0) {
            let ch: Byte = UInt8(this.bsBuff >> 24 & 0xff)
            writeByte(ch)

            // write 8-bit
            this.bsBuff <<= 8
            this.bsLive -= 8
        }
    }