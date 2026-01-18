    private func bsPutInt(u: Int64): Unit {
        bsW(8, (u >> 24))
        bsW(8, (u >> 16))
        bsW(8, (u >> 8))
        bsW(8, u)
    }