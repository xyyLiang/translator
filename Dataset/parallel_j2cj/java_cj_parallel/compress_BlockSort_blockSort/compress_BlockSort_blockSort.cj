    func blockSort(data: BZip2OutputStreamData, last: Int64): Unit {
        this.data = data
        (this.workLimit, this.workDone, this.firstAttempt) = (WORK_FACTOR * last, 0, true)

        match {
            case last < 9999 => fallbackSort(data, last)
            case _ =>
                mainSort(last)
                if (this.workDone > this.workLimit && this.firstAttempt) {
                    fallbackSort(data, last)
                }
        }

        data.origPtr = -1
        for (i in 0..=last) {
            if (fmap[i] == 0) {
                data.origPtr = i
                break
            }
        }
    }