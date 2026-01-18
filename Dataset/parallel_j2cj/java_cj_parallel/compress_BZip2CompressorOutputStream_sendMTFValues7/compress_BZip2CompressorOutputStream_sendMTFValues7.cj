    private func sendMTFValues7(): Unit {
        let len: Array<Array<Byte>> = dataShadow.sendMTFValues_len
        let code: Array<Array<Int64>> = dataShadow.sendMTFValues_code
        let selector: Array<Byte> = dataShadow.selector
        let sfmap: Array<UInt16> = dataShadow.sfmap
        let nMTFShadow: Int64 = this.nMTF

        var selCtr: Int64 = 0
        var bsLiveShadow: Int64 = this.bsLive
        var bsBuffShadow: Int64 = this.bsBuff

        var gs: Int64 = 0
        while (gs < nMTFShadow) {
            let ge: Int64 = math.min(gs + G_SIZE - 1, nMTFShadow - 1)
            let selector_selCtr: Int64 = Int64(selector[selCtr])
            let code_selCtr: Array<Int64> = code[selector_selCtr]
            let len_selCtr: Array<Byte> = len[selector_selCtr]

            while (gs <= ge) {
                let sfmap_i: Int64 = Int64(sfmap[gs])

                while (bsLiveShadow >= 8) {
                    writeByte(UInt8(bsBuffShadow >> 24 & 0xff))
                    bsBuffShadow <<= 8
                    bsLiveShadow -= 8
                }
                let n: Int64 = Int64(len_selCtr[sfmap_i])
                bsBuffShadow |= code_selCtr[sfmap_i] << (32 - bsLiveShadow - n)
                bsLiveShadow += n

                gs++
            }
            gs = ge + 1
            selCtr++
        }
        this.bsBuff = bsBuffShadow
        this.bsLive = bsLiveShadow
    }