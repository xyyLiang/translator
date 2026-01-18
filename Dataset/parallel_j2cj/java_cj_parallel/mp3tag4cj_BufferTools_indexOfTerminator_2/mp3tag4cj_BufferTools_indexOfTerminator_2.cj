    @OverflowWrapping
    public static func indexOfTerminator(bytes: Array<Int8>, fromIndex: Int32, terminatorLength: Int32): Int32 {
        var marker: Int32 = -1
        for (i in fromIndex..(Int32(bytes.size) - terminatorLength) + 1) {
            if ((i - fromIndex) % terminatorLength == 0) {
                var matched: Int32 = 0
                for (_ in 0..terminatorLength) {
                    if (bytes[Int64(i) + Int64(matched)] != 0) {
                        break
                    }
                    matched++
                }
                if (matched == terminatorLength) {
                    marker = i
                    break
                }
            }
        }
        return marker
    }