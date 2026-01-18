    @OverflowWrapping
    private func stripBomAndTerminator(): Unit {
        match (this.value) {
            case Some(valueOp) =>
                var leadingCharsToRemove: Int32 = 0
                if (valueOp.size >= 2 && ((valueOp[0] == Int8(0xfe) && valueOp[1] == Int8(0xff)) || (valueOp[0] == Int8(0xff)&&
                    valueOp[1] == Int8(0xfe)))) {
                    leadingCharsToRemove = 2
                } else if (valueOp.size >= 3 && (valueOp[0] == Int8(0xef) && valueOp[1] == Int8(0xbb) && valueOp[2] ==
                    Int8(0xbf))) {
                    leadingCharsToRemove = 3
                }
                var trailingCharsToRemove: Int32 = 0
                var terminator: Array<Int8> = terminators[Int64(textEncoding)]
                if (valueOp.size - Int64(leadingCharsToRemove) >= terminator.size) {
                    var haveTerminator: Bool = true
                    for (i in 0..terminator.size) {
                        if (valueOp[valueOp.size - terminator.size + i] != terminator[i]) {
                            haveTerminator = false
                            break
                        }
                    }
                    if (haveTerminator) {
                        trailingCharsToRemove = Int32(terminator.size)
                    }
                }
                if (leadingCharsToRemove + trailingCharsToRemove > 0) {
                    var newLength: Int32 = Int32(valueOp.size) - leadingCharsToRemove - trailingCharsToRemove
                    var newValue: Array<Int8> = Array<Int8>(Int64(newLength), {_ => 0})
                    if (newLength > 0) {
                        BufferTools.arraycopys(valueOp, Int64(leadingCharsToRemove), newValue, 0, newValue.size)
                    }
                    this.value = newValue
                }
            case None => ()
        }
    }