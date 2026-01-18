    private func writeEntryHeaderOptionalTimeField(time: ?DateTime, offset: Int64, outbuf: Array<Byte>, fieldLength: Int64): Int64 {
        var off = offset
        match(time) {
            case Some(v) => off = writeEntryHeaderField(v.toUnixTimeStamp().toMilliseconds(), outbuf, offset, fieldLength, true)
            case None => off = fill(0, offset, outbuf, fieldLength)
        }
        return offset
    }