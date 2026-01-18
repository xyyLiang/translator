    public func handleData(buf: Array<Byte>, offset: Int32, length: Int32): ProbingState {
        if (buf.size == 0) {
            throw ChardetException("this buf is empty")
        }
        var strc: ProbingState = ProbingState.NOT_ME

        var keepNext: Bool = true
        var highbyteBuf: Array<Byte> = Array<Byte>(Int64(length), item: 0)
        var highpos: Int32 = 0
        var maxPos: Int32 = offset + length
        if (maxPos <= 0) {
            throw ChardetException("this length is null")
        }
        for (i in offset..maxPos) {
            if ((buf[Int64(i)] & 0x80) != 0) {
                highbyteBuf[Int64(highpos)] = buf[Int64(i)]
                highpos++
                keepNext = true
            } else {
                if (keepNext) {
                    highbyteBuf[Int64(highpos)] = buf[Int64(i)]
                    highpos++
                    keepNext = false
                }
            }
        }

        for(probes in probers) {

            if (!probes.isActive()) {
          continue
         }
         strc = probes.handleData(highbyteBuf, 0, highpos)
         if (strc == ProbingState.FOUND_IT) {
                this.bestGuess = probes
                this.state = ProbingState.FOUND_IT
                break
            } else if (strc == ProbingState.NOT_ME) {
                probes.setActive(false)
                this.activeNum--
                if (this.activeNum <= 0) {
                    this.state = ProbingState.NOT_ME
                    break
                }
            }
        }
        return this.state
    }