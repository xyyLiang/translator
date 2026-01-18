    private func recvDecodingTables(): Unit {
        let bin: BitInputStream = this.bin()
        let dataShadow: BZip2InputStreamData = this.data()
        let inUse: Array<Bool> = dataShadow.inUse
        let pos: Array<UInt8> = dataShadow.recvDecodingTables_pos
        let selector: Array<UInt8> = dataShadow.selector
        let selectorMtf: Array<UInt8> = dataShadow.selectorMtf

        var inUse16: Int64 = 0

        /* Receive the mapping table */
        for (i in 0..16) {
            if (bsGetBit(bin)) {
                inUse16 |= 1 << i
            }
        }

        inUse[..] = false
        for (i in 0..16) {
            if ((inUse16 & (1 << i)) != 0) {
                let i16: Int64 = i << 4
                for (j in 0..16) {
                    if (bsGetBit(bin)) {
                        inUse[i16 + j] = true
                    }
                }
            }
        }

        makeMaps()
        let alphaSize: Int64 = this.nInUse + 2

        /* Now the selectors */
        let nGroups: Int64 = bsR(bin, 3)
        let selectors: Int64 = bsR(bin, 15)
        if (selectors < 0) {
            throw CompressorException("Corrupted input, nSelectors value negative")
        }
        checkBounds(alphaSize, MAX_ALPHA_SIZE + 1, "alphaSize")
        checkBounds(nGroups, N_GROUPS + 1, "nGroups")

        // Don't fail on nSelectors overflowing boundaries but discard the values in overflow
        for (i in 0..selectors) {
            var j: UInt8 = 0
            while (bsGetBit(bin)) {
                j += 1
            }
            if (i < MAX_SELECTORS) {
                selectorMtf[i] = j
            }
        }
        let nSelectors: Int64 = min(selectors, MAX_SELECTORS)

        /* Undo the MTF values for the selectors. */
        for (v in nGroups - 1..=0 : -1) {
            pos[v] = UInt8(v & 0xff)
        }

        nSelectorsLoop(nSelectors, selectorMtf, pos, selector)

        /* Now the coding tables */
        nowTheCodingTables(nGroups, bin, dataShadow.temp_charArray2d, alphaSize)

        // finally create the Huffman tables
        createHuffmanDecodingTables(alphaSize, nGroups)
    }
    private func nSelectorsLoop(nSelectors: Int64, selectorMtf: Array<UInt8>, pos: Array<UInt8>, selector: Array<UInt8>): Unit {
        for (i in 0..nSelectors) {
            var v: Int64 = Int64(selectorMtf[i])
            checkBounds(v, N_GROUPS, "selectorMtf")
            let tmp: UInt8 = pos[v]
            while (v > 0) {
                // nearly all times v is zero, 4 in most other cases
                pos[v] = pos[v - 1]
                v -= 1
            }
            pos[0] = tmp
            selector[i] = tmp
        }
    }
    private func nowTheCodingTables(nGroups: Int64, bin: BitInputStream, len: Array<Array<UInt8>>, alphaSize: Int64): Unit {
        for (t in 0..nGroups) {
            var curr: Int64 = bsR(bin, 5)
            let len_t: Array<UInt8> = len[t]
            for (i in 0..alphaSize) {
                while (bsGetBit(bin)) {
                    curr += if (bsGetBit(bin)) {
                        -1
                    } else {
                        1
                    }
                }
                len_t[i] = UInt8(curr & 0xff)
            }
        }
    }