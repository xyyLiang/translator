    private func hbAssignCodes(code: Array<Int64>, length: Array<Byte>, minLen: Int64, maxLen: Int64, alphaSize: Int64): Unit {
        var vec: Int64 = 0
        for (n in minLen..=maxLen) {
            for (i in 0..alphaSize) {
                if (Int64((length[i])) == n) {
                    code[i] = vec
                    vec++
                }
            }
            vec <<= 1
        }
    }