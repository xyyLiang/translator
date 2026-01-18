    static func encodeToCodewords(str: StringBuilder): String {
        let sb = str.toCharArray()
        let v = (1600 * UInt32(sb[0])) + (40 * UInt32(sb[1])) + UInt32(sb[2]) + 1
        let cw1 = Char(v / 256)
        let cw2 = Char(v % 256)
        "${cw1}${cw2}"
    }