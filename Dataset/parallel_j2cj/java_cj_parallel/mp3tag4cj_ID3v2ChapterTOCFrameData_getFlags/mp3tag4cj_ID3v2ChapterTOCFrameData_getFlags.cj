    private func getFlags(): Int8 {
        var b: Int8 = 0
        if (isRoots) {
            b |= 0x01
        }
        if (isOrdereds) {
            b |= 0x02
        }
        return b
    }