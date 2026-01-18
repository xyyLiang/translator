    public func writeStamp (stamp: Int64) {
        if (stamp <= mLastTimestamp) {
            if (stamp == mLastTimestamp) {
                logger.warn("(file '') Trying to re-write existing timestamp (${stamp})")
                return
            }
        }

        mWriteArray[0] = UInt8(UInt32('['))
        mWriteArray[1] = UInt8(UInt32('0'))
        mWriteArray[2] = UInt8(UInt32('x'))
        mWriteArray[19] = UInt8(UInt32(']'))
        mWriteArray[20] = UInt8(UInt32('\r'))
        mWriteArray[21] = UInt8(UInt32('\n'))

        var stampTemp: Int64 = stamp
        for(i in 18..2 : -1) {
            var val: Int64 = stampTemp & 0x0f
            // Char -> uint8
            mWriteArray[i] = UInt8(UInt32(HEX_DIGITS.toRuneArray()[val]))

            stampTemp = (stampTemp >> 4)
        }
        mFile.seek(SeekPosition.Begin(0))
        mFile.write(mWriteArray)

    }