    func checkChecksum(): Bool {
        let firstPair = this.pairs[0]
        let checkCharacter = firstPair.leftChar
        let firstCharacter = firstPair.rightChar

        if (let Some(fc) = firstCharacter) {
            var checksum = fc.checksumPortion
            var s = 2

            for (i in 1..this.pairs.size) {
                let currentPair = this.pairs[i]
                checksum += currentPair.leftChar.checksumPortion
                s++
                let currentRightChar = currentPair.rightChar
                if (let Some(crc) = currentRightChar) {
                    checksum += crc.checksumPortion
                    s++
                }
            }

            checksum %= 211

            let checkCharacterValue = 211 * (s - 4) + checksum

            checkCharacterValue == checkCharacter.value
        } else {
            false
        }
    }