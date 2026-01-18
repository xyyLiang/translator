    private func skipWhiteSpace(i0: Int64, s: Array<Char>): Int64 {
        var i = i0
        while(i < s.size && (s[i] == ' ')) {
            i++
        }
        return i
    }  