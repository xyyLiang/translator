    private func sendMTFValues6(nGroups: Int64, alphaSize: Int64): Unit {
        let len: Array<Array<Byte>> = this.data.sendMTFValues_len

        var bsLiveShadow: Int64 = this.bsLive
        var bsBuffShadow: Int64 = this.bsBuff

        for (t in 0..nGroups) {
            let len_t: Array<Byte> = len[t]
            var curr: UInt8 = len_t[0]
            while (bsLiveShadow >= 8) {
                writeByte(UInt8(bsBuffShadow >> 24 & 0xff)) // write 8-bit
                bsBuffShadow <<= 8
                bsLiveShadow -= 8
            }
            bsBuffShadow |= Int64(curr) << (32 - bsLiveShadow - 5)
            bsLiveShadow += 5

            for (i in 0..alphaSize) {
                let lti: UInt8 = len_t[i]
                while (curr < lti) {
                    while (bsLiveShadow >= 8) {
                        writeByte(UInt8(bsBuffShadow >> 24 & 0xff)) // write 8-bit
                        bsBuffShadow <<= 8
                        bsLiveShadow -= 8
                    }
                    bsBuffShadow |= 2 << (32 - bsLiveShadow - 2)
                    bsLiveShadow += 2

                    curr++ /* 10 */
                }

                while (curr > lti) {
                    // inlined: bsW(2, 3)
                    while (bsLiveShadow >= 8) {
                        writeByte(UInt8(bsBuffShadow >> 24 & 0xff)) // write 8-bit
                        bsBuffShadow <<= 8
                        bsLiveShadow -= 8
                    }
                    bsBuffShadow |= 3 << (32 - bsLiveShadow - 2)
                    bsLiveShadow += 2

                    curr-- /* 11 */
                }

                // inlined: bsW(1, 0)
                while (bsLiveShadow >= 8) {
                    writeByte(UInt8(bsBuffShadow >> 24 & 0xff)) // write 8-bit
                    bsBuffShadow <<= 8
                    bsLiveShadow -= 8
                }

                // bsBuffShadow |= 0 << (32 - bsLiveShadow - 1)
                bsLiveShadow++
            }
        }
        this.bsBuff = bsBuffShadow
        this.bsLive = bsLiveShadow
    }