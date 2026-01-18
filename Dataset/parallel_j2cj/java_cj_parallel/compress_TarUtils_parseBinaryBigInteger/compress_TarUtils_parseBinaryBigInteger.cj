    @OverflowWrapping
    private static func parseBinaryBigInteger(buffer: Array<Byte>, offset: Int64, length: Int64, negative: Bool): Int64 {
        let remainder: Array<Byte> = Array<Byte>(length - 1, item: 0)
        ArrayCopy(buffer, offset + 1, remainder, 0, length - 1)
        var val: BigInt = DecoderUtils.decode(remainder)
        if (negative) {
             val = -val
        }
        if (remainder.size > 63) {
            throw IllegalArgumentException(/* "At offset " + offset + ", "
            + length + " byte binary Int64"
            + " exceeds maximum signed long"
            + " value" */)
        }
        return if (negative) {
            match((-val).checkedToInt()){
                case None => 0
                case Some(v) => v
            }
        } else {
            match(val.checkedToInt()){
                case None => 0
                case Some(v) => v
            }
        }
    }