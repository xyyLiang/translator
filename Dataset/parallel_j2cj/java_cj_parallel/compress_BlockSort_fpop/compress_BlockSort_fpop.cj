    private func fpop(sp: Int64): (Int64, Int64) {
        return (stack_ll[sp], stack_hh[sp])
    }