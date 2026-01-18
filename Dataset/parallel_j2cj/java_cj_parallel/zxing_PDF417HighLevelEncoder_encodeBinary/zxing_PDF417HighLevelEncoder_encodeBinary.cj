    static func encodeBinary(bytes: Array<UInt8>, startpos: Int64, count: Int64, startmode: Int64, sb: StringBuilder) {
        if (count == 1 && startmode == TEXT_COMPACTION) {
            sb.append(Char(SHIFT_TO_BYTE))
        } else {
            if ((count % 6) == 0) {
                sb.append(Char(LATCH_TO_BYTE))
            } else {
                sb.append(Char(LATCH_TO_BYTE_PADDED))
            }
        }
        var idx = startpos
        if (count >= 6) {
            let chars = Array<Char>(5, item: Char(0))
            while ((startpos + count - idx) >= 6) {
                var t = 0
                for (i in 0..6) {
                    t <<= 8
                    t += Int64(bytes[idx + i]) & 0xff
                }
                for (i in 0..5) {
                    chars[i] = Char(t % 900)
                    t /= 900
                }
                for (i in (chars.size - 1)..-1 : -1) {
                    sb.append(chars[i])
                }
                idx += 6
            }
        }
        for (i in idx..(startpos + count)) {
            let ch = UInt32(bytes[i]) & 0xff
            sb.append(Char(ch))
        }
    }