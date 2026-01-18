    static func encodeMultiECIBinary(
        input: ECIInput,
        startpos: Int64,
        count: Int64,
        startmode: Int64,
        sb: StringBuilder
    ) {
        let end = math.min(startpos + count, input.length())
        var localStart = startpos
        while (true) {
            while (localStart < end && input.isECI(localStart)) {
                encodingECI(input[localStart], sb)
                localStart++
            }
            var localEnd = localStart

            while (localEnd < end && !input.isECI(localEnd)) {
                localEnd++
            }

            let localCount = localEnd - localStart
            if (localCount <= 0) {
                break
            } else {
                encodeBinary(
                    subBytes(input, localStart, localEnd),
                    0,
                    localCount,
                    if (localStart == startpos) {
                        startmode
                    } else {
                        BYTE_COMPACTION
                    },
                    sb
                )
                localStart = localEnd
            }
        }
    }