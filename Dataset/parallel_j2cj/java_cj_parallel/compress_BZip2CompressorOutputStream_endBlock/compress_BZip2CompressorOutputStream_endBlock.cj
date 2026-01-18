    private func endBlock(): Unit {
        this.blockCRC = this.crc.getFinalCRC()

        this.combinedCRC = (this.combinedCRC << 1) | (this.combinedCRC >> 31)
        this.combinedCRC ^= this.blockCRC

        // empty block at end of file
        if (this.last == -1) {
            return
        }

        blockSort()

        bsPutUByte(0x31)
        bsPutUByte(0x41)
        bsPutUByte(0x59)
        bsPutUByte(0x26)
        bsPutUByte(0x53)
        bsPutUByte(0x59)

        /* Now the block's CRC, so it is in a known place. */
        bsPutInt(Int64(this.blockCRC))

        /* Now a single bit indicating no randomisation. */
        bsW(1, 0)

        /* Finally, block's contents proper. */
        moveToFrontCodeAndSend()
    }