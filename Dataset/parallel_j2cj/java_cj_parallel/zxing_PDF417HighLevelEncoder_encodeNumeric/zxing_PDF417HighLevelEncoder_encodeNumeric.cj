    static func encodeNumeric(input: ECIInput, startpos: Int64, count: Int64, sb: StringBuilder) {
        var idx = 0
        let tmp = StringBuilder()
        while (idx < count) {
            tmp.clear()
            let len = math.min(44, count - idx)
            let part = "1${input[(startpos + idx)..(startpos + idx + len)]}"
            var bigint = Int64.parse(part)
            do {
                tmp.append(Char(bigint % 900))
                bigint /= 900
            } while (bigint != 0)

            for (i in (tmp.size - 1)..-1 : -1) {
                sb.append(tmp.get(i).getOrThrow())
            }
            idx += len
        }
    }