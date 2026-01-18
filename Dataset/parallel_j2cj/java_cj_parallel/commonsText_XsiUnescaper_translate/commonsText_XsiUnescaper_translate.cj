    public override func translate(input: String, index: Int64, writer: Writer): Int64 {
        if (index != 0) {
            throw IllegalArgumentException("XsiUnescaper should never reach the [1] index");
        }

        let s = input
        var segmentStart = 0
        var searchOffset = 0
        while (true) {
            let pos = s.indexOf(BACKSLASH, searchOffset) ?? -1
            if (pos == -1) {
                if (segmentStart < s.size) {
                    writer.write(s.substring(segmentStart))
                }
                break
            }
            if (pos > segmentStart) {
                writer.write(s.substring(segmentStart, pos - segmentStart))
            }
            segmentStart = pos + 1
            searchOffset = pos + 2
        }

        return input.size
    }