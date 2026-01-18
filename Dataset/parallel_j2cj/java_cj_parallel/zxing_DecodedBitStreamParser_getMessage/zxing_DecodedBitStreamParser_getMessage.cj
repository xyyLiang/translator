    static func getMessage(bytes: Array<UInt8>, start: Int64, len: Int64): String {
        let sb = StringBuilder()
        var shift = -1
        var set = 0
        var lastset = 0
        var i = start
        while (i < (start + len)) {
            let c = SETS[set].charAt(Int64(bytes[i]))
            if (c == LATCHA) {
                set = 0
                shift = -1
            } else if (c == LATCHB) {
                set = 1
                shift = -1
            } else if (c == SHIFTA || c == SHIFTB || c == SHIFTC || c == SHIFTD || c == SHIFTE) {
                lastset = set
                set = Int64(UInt32(c) - UInt32(SHIFTA))
                shift = 1
            } else if (c == TWOSHIFTA) {
                lastset = set
                set = 0
                shift = 2
            } else if (c == THREESHIFTA) {
                lastset = set
                set = 0
                shift = 3
            } else if (c == NS) {
                i++
                let p0 = (Int32(bytes[i]) << 24)
                i++
                let p1 = (Int32(bytes[i]) << 18)
                i++
                let p2 = (Int32(bytes[i]) << 12)
                i++
                let p3 = (Int32(bytes[i]) << 6)
                i++
                let p4 = Int32(bytes[i])
                let nsval = p0 + p1 + p2 + p3 + p4
                sb.append(nsval.format("9"))
            } else if (c == LOCK) {
                shift = -1
            } else {
                sb.append(c)
            }
            shift--
            if (shift == 0) {
                set = lastset
            }
        }
        while (sb.size > 0 && sb.toCharArray()[sb.size - 1] == PAD) {
            sb.removeLast()
        }
        sb.toString()
    }