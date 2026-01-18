    private func fswap(fmap: Array<Int64>, zz1: Int64, zz2: Int64): Unit {
        let zztmp: Int64 = fmap[zz1]
        fmap[zz1] = fmap[zz2]
        fmap[zz2] = zztmp
    }