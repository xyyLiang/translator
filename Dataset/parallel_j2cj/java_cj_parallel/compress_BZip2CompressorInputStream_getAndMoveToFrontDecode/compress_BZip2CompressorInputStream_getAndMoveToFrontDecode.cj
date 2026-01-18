    private func getAndMoveToFrontDecode(): Unit {
        let bin: BitInputStream = this.bin()
        this.origPtr = bsR(bin, 24)
        recvDecodingTables()

        let limitLast: Int64 = this.blockSize100k * 100000

        /*
         * Setting up the unzftab entries here is not strictly necessary, but it
         * does save having to do it later in a separate pass, and so saves a
         * block's worth of cache misses.
         */
        for (i in 255..=0 : -1) {
            yy[i] = UInt8(i & 0xff)
            unzftab[i] = 0
        }

        let eob: Int64 = this.nInUse + 1
        let v: Changablebzin = Changablebzin()

        (v.groupNo, v.groupPos, v.nextSym, v.lastShadow, v.zt) = (0, G_SIZE - 1, getAndMoveToFrontDecode0(), -1, Int64(selector[v.
                    groupNo]))
        checkBounds(v.zt, N_GROUPS, "zt")
        (v.base_zt, v.limit_zt, v.perm_zt, v.minLens_zt) = (base[v.zt], limit[v.zt], perm[v.zt], minLens[v.zt])
        while (v.nextSym != eob) {
            if ((v.nextSym == RUNA) || (v.nextSym == RUNB)) {
                getAndMoveToFrontDecode1(bin, limitLast, v)
            } else {
                getAndMoveToFrontDecode2(bin, limitLast, v)
            }
        }

        this.last = v.lastShadow
    }
    private func getAndMoveToFrontDecode1(bin: BitInputStream, limitLast: Int64, v: Changablebzin) {
        var s = -1
        var n = 1
        while (true) {
            match {
                case v.nextSym == RUNA => s += n
                case v.nextSym == RUNB => s += n << 1
                case _ => break
            }

            if (v.groupPos == 0) {
                v.groupPos = G_SIZE - 1
                v.groupNo += 1
                checkBounds(v.groupNo, MAX_SELECTORS, "groupNo")
                v.zt = Int64(selector[v.groupNo])
                checkBounds(v.zt, N_GROUPS, "zt")
                (v.base_zt, v.limit_zt, v.perm_zt, v.minLens_zt) = (base[v.zt], limit[v.zt], perm[v.zt], minLens[v.zt])
            } else {
                v.groupPos -= 1
            }

            var zn = v.minLens_zt
            checkBounds(zn, MAX_ALPHA_SIZE, "zn")
            var zvec = bsR(bin, zn)
            while (zvec > v.limit_zt[zn]) {
                zn += 1
                checkBounds(zn, MAX_ALPHA_SIZE, "zn")
                zvec = (zvec << 1) | bsR(bin, 1)
            }
            let tmp = zvec - v.base_zt[zn]
            checkBounds(tmp, MAX_ALPHA_SIZE, "zvec")
            v.nextSym = v.perm_zt[tmp]
            n <<= 1
        }
        checkBounds(s, this.data().ll8.size, "s")

        let yy0 = Int64(yy[0])
        checkBounds(yy0, 256, "yy")
        let ch: UInt8 = seqToUnseq[yy0]
        unzftab[Int64(ch)] += s + 1
        v.lastShadow += 1
        let fromIndex: Int64 = v.lastShadow
        v.lastShadow += s
        checkBounds(v.lastShadow, this.data().ll8.size, "lastShadow")
        ll8[fromIndex..=v.lastShadow] = ch

        if (v.lastShadow >= limitLast) {
            throw CompressorException("Block overrun while expanding RLE in MTF, ${v.lastShadow} exceeds ${limitLast}")
        }
    }
    private func getAndMoveToFrontDecode2(bin: BitInputStream, limitLast: Int64, v: Changablebzin) {
        v.lastShadow += 1
        if (v.lastShadow >= limitLast) {
            throw CompressorException("Block overrun in MTF, {lastShadow} exceeds ${limitLast}")
        }
        checkBounds(v.nextSym, 256 + 1, "nextSym")

        let tmp: UInt8 = yy[v.nextSym - 1]
        checkBounds(Int64(tmp), 256, "yy")
        unzftab[Int64(seqToUnseq[tmp])] += 1
        ll8[v.lastShadow] = seqToUnseq[tmp]

        arrcopy(yy, v.nextSym)

        yy[0] = tmp

        if (v.groupPos == 0) {
            v.groupPos = G_SIZE - 1
            v.groupNo += 1
            checkBounds(v.groupNo, MAX_SELECTORS, "groupNo")
            v.zt = Int64(selector[v.groupNo])
            checkBounds(v.zt, N_GROUPS, "zt")
            (v.base_zt, v.limit_zt, v.perm_zt, v.minLens_zt) = (base[v.zt], limit[v.zt], perm[v.zt], minLens[v.zt])
        } else {
            v.groupPos -= 1
        }

        var (zn, zvec) = znzv(v.minLens_zt, bin, v.limit_zt)
        let idx = zvec - v.base_zt[zn]
        checkBounds(idx, MAX_ALPHA_SIZE, "zvec")
        v.nextSym = v.perm_zt[idx]
    }
    private func getAndMoveToFrontDecode0(): Int64 {
        let dataShadow: BZip2InputStreamData = this.data()
        let zt: Int64 = Int64(dataShadow.selector[0])
        checkBounds(zt, N_GROUPS, "zt")
        let limit_zt: Array<Int64> = dataShadow.limit[zt]
        var zn: Int64 = dataShadow.minLens[zt]
        checkBounds(zn, MAX_ALPHA_SIZE, "zn")
        var zvec: Int64 = bsR(this.bin(), zn)
        while (zvec > limit_zt[zn]) {
            zn += 1
            checkBounds(zn, MAX_ALPHA_SIZE, "zn")
            zvec = (zvec << 1) | bsR(this.bin(), 1)
        }
        let tmp: Int64 = zvec - dataShadow.base[zt][zn]
        checkBounds(tmp, MAX_ALPHA_SIZE, "zvec")

        return dataShadow.perm[zt][tmp]
    }