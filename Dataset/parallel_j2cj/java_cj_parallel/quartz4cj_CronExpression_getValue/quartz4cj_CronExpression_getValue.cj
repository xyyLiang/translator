    private func getValue(parsedValue: String, s: Array<Char>, i0: Int64): (Int64,Int64) {
        var i = i0
        var c = s[i]
        let b = StringBuilder()
        b.append(parsedValue)
        while (c >= '0' && c <= '9') {
            b.append(c)
            i++
            if (i >= s.size) {
                break
            }
            c = s[i]
        } 
        let pos = i
        let value = Int64.parse(b.toString())
        return (value,pos)
    } 