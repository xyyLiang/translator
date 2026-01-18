    static func encodeToCodewords(str: StringBuilder): String {
        let len = str.size
        if (len == 0) {
            throw IllegalArgumentException("StringBuilder must not be empty")
        }
        let sb = str.toCharArray()
        let c1 = UInt32(sb[0])
        let c2 = UInt32(if (len >= 2) {
                sb[1]
            } else {
                Char(0)
            })
        let c3 = UInt32(if (len >= 3) {
                sb[2]
            } else {
                Char(0)
            })
        let c4 = UInt32(if (len >= 4) {
                sb[3]
            } else {
                Char(0)
            })

        let v = (c1 << 18) + (c2 << 12) + (c3 << 6) + c4
        let cw1 = Char((v >> 16) & 255)
        let cw2 = Char((v >> 8) & 255)
        let cw3 = Char(v & 255)
        let res = StringBuilder()
        res.append(cw1)
        if (len >= 2) {
            res.append(cw2)
        }
        if (len >= 3) {
            res.append(cw3)
        }
        res.toString()
    }