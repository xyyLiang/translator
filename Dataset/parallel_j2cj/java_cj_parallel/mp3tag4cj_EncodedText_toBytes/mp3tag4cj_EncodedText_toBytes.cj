    @OverflowWrapping
    public func toBytes(includeBom: Bool, includeTerminator: Bool): Array<Int8> {
        match (this.value) {
            case Some(valueOp) =>
                characterSetForTextEncoding(textEncoding);

                // ensured textEncoding is valid
                var includeBomNum: Int32
                var includeTerminatorNum: Int32
                if (includeBom) {
                    includeBomNum = Int32(boms[Int64(textEncoding)].size)
                } else {
                    includeBomNum = Int32(0)
                }
                if (includeTerminator) {
                    includeTerminatorNum = Int32(getTerminator().size)
                } else {
                    includeTerminatorNum = Int32(0)
                }
                var newLength: Int32 = Int32(valueOp.size) + includeBomNum + includeTerminatorNum
                if (Int64(newLength) == valueOp.size) {
                    return valueOp
                } else {
                    var bytes: Array<Int8> = Array<Int8>(Int64(newLength), {_ => 0})
                    var i: Int32 = 0;
                    if (includeBom) {
                        var bom: Array<Int8> = boms[Int64(textEncoding)]
                        if (bom.size > 0) {
                            BufferTools.arraycopys(
                                boms[Int64(textEncoding)],
                                0,
                                bytes,
                                Int64(i),
                                boms[Int64(textEncoding)].size
                            )
                            i += Int32(boms[Int64(textEncoding)].size)
                        }
                    }
                    if (valueOp.size > 0) {
                        BufferTools.arraycopys(valueOp, 0, bytes, Int64(i), valueOp.size)
                        i += Int32(valueOp.size)
                    }
                    if (includeTerminator) {
                        var terminator: Array<Int8> = getTerminator()
                        if (terminator.size > 0) {
                            BufferTools.arraycopys(terminator, 0, bytes, Int64(i), terminator.size);
                        }
                    }
                    return bytes
                }
            case None => return []
        }
    }