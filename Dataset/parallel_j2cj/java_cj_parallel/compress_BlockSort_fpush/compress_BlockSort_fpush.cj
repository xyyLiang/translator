    private func fpush(sp: Int64, lz: Int64, hz: Int64): Unit {
        stack_ll[sp] = lz
        stack_hh[sp] = hz
    }