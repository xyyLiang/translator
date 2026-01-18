    init(c: Char, encoderIndex: Int64, previous: ?InputEdge, fnc1: Int64) {
        this.c = if (c == Char(fnc1)) {
            Char(1000)
        } else {
            c
        }
        this.encoderIndex = encoderIndex
        this.previous = previous

        var size = if (this.c == Char(1000)) {
            1
        } else {
            "${c}".toUtf8Array().size
        }

        let previousEncoderIndex = if (let Some(pre) = previous) {
            size += pre.cachedTotalSize
            pre.encoderIndex
        } else {
            0
        }
        if (previousEncoderIndex != encoderIndex) {
            size += MinimalECIInput.COST_PER_ECI
        }
        this.cachedTotalSize = size
    }