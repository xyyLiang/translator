    public func setRange(start: Int64, end: Int64) {
        if (end < start || start < 0 || end > size) {
            throw IllegalArgumentException()
        }
        if (end == start) {
            return
        }
        let mEnd = end - 1
        let firstInt = start / 32
        let lastInt = mEnd / 32
        for (i in firstInt..=lastInt) {
            let f = if (i > firstInt) {
                0
            } else {
                start & 0x1F
            }
            let l = if (i < lastInt) {
                31
            } else {
                mEnd & 0x1F
            }
            this.bits[i] |= (2 << l) - (1 << f)
        }
    }