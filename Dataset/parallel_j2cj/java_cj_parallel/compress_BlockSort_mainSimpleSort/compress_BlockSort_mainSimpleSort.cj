    private func mainSimpleSort(
        lo: Int64,
        hi: Int64,
        d: Int64,
        lastShadow: Int64
    ): Bool {
        let bigN: Int64 = hi - lo + 1
        if (bigN < 2) {
            return this.firstAttempt && (this.workDone > this.workLimit)
        }

        let changable = Changable()
        changable.workDoneShadow = this.workDone
        changable.hp = 0
        while (INCS[changable.hp] < bigN) {
            changable.hp++
        }

        let lastPlus1: Int64 = lastShadow + 1

        // Following block contains unrolled code which could be shortened by
        // coding it in additional loops.
        changable.hp--
        while (changable.hp >= 0) {
            let sig = hpLoop(
                lo,
                hi,
                d,
                lastShadow,
                lastPlus1,
                changable
            )
            changable.hp--
            match (sig) {
                case HP(CONTINUE) => continue
                case HP(BREAK) => break
                case _ => ()
            }
        }

        this.workDone = changable.workDoneShadow
        return firstAttemptShadow && (changable.workDoneShadow > workLimitShadow)
    }
    private func hpLoop(
        lo: Int64,
        hi: Int64,
        d: Int64,
        lastShadow: Int64,
        lastPlus1: Int64,
        changable: Changable
    ): Loop {
        let h: Int64 = INCS[changable.hp]
        let mj: Int64 = lo + h - 1

        var i: Int64 = lo + h
        while (i <= hi) {
            // copy
            var k: Int64 = 2
            while ((i <= hi) && (k >= 0)) { // i loop
                let v: Int64 = fmap[i]
                let vd: Int64 = v + d
                changable.j = i
                changable.onceRunned = false
                changable.a = 0

                while (true) { // hammerLoop
                    let sig = hammerLoop(
                        d,
                        lastShadow,
                        lastPlus1,
                        h,
                        mj,
                        vd,
                        changable
                    )
                    match (sig) {
                        case HAMMER(CONTINUE) => continue
                        case HAMMER(BREAK) => break
                        case HAMMER(NOTHING) => ()
                        case _ => return sig
                    }
                }

                fmap[changable.j] = v

                // i loop finally
                i++
                k--
            }

            if (firstAttemptShadow && (i <= hi) && (changable.workDoneShadow > workLimitShadow)) {
                return HP(BREAK)
            }
        }
        return HP(NOTHING)
    }
    private func hammerLoop(
        d: Int64,
        lastShadow: Int64,
        lastPlus1: Int64,
        h: Int64,
        mj: Int64,
        vd: Int64,
        changable: Changable
    ): Loop {
        if (changable.onceRunned) {
            fmap[changable.j] = changable.a
            changable.j -= h
            if (changable.j <= mj) { //NOSONAR
                return HAMMER(BREAK)
            }
        } else {
            changable.onceRunned = true
        }

        changable.a = fmap[changable.j - h]
        var i1: Int64 = changable.a + d
        var i2: Int64 = vd

        // following could be done in a loop, but unrolled it for performance:
        if (let Some(v) <- compare(block[i1 + 1], block[i2 + 1])) {
            return v
        }
        if (let Some(v) <- compare(block[i1 + 2], block[i2 + 2])) {
            return v
        }
        if (let Some(v) <- compare(block[i1 + 3], block[i2 + 3])) {
            return v
        }
        if (let Some(v) <- compare(block[i1 + 4], block[i2 + 4])) {
            return v
        }
        if (let Some(v) <- compare(block[i1 + 5], block[i2 + 5])) {
            return v
        }
        i1 += 6
        i2 += 6
        if (let Some(v) <- compare(block[i1], block[i2])) {
            return v
        }
        var x: Int64 = lastShadow
        while (x > 0) { // X loop
            x -= 4
            if (let Some(v) <- compare(block[i1 + 1], block[i2 + 1])) {
                return v
            }
            if (let Some(v) <- compare(quadrant[i1], quadrant[i2])) {
                return v
            }
            if (let Some(v) <- compare(block[i1 + 2], block[i2 + 2])) {
                return v
            }
            if (let Some(v) <- compare(quadrant[i1 + 1], quadrant[i2 + 1])) {
                return v
            }
            if (let Some(v) <- compare(block[i1 + 3], block[i2 + 3])) {
                return v
            }
            if (let Some(v) <- compare(quadrant[i1 + 2], quadrant[i2 + 2])) {
                return v
            }
            if (let Some(v) <- compare(block[i1 + 4], block[i2 + 4])) {
                return v
            }
            if (let Some(v) <- compare(quadrant[i1 + 3], quadrant[i2 + 3])) {
                return v
            }
            i1 += 4
            if (i1 >= lastPlus1) { //NOSONAR
                i1 -= lastPlus1
            }
            i2 += 4
            if (i2 >= lastPlus1) { //NOSONAR
                i2 -= lastPlus1
            }
            changable.workDoneShadow++
            continue
            // continue X loop
        }
        return HAMMER(BREAK)
    }
    private func compare<T>(a: T, b: T): ?Loop where T <: Comparable<T> {
        match {
            case a == b => None
            case a > b => HAMMER(CONTINUE)
            case _ => HAMMER(BREAK)
        }
    }