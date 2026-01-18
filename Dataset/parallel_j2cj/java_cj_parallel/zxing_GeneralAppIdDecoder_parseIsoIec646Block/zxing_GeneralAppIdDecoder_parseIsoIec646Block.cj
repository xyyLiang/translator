    func parseIsoIec646Block(): BlockParsedResult {
        while (isStillIsoIec646(current.position)) {
            let iso = decodeIsoIec646(current.position)
            current.position = iso.newPosition

            if (iso.isFNC1()) {
                let information = DecodedInformation(current.position, buffer.toString())
                return BlockParsedResult(information, true)
            }
            buffer.append(iso.value)
        }

        if (isAlphaOr646ToNumericLatch(current.position)) {
            current.incrementPosition(3)
            current.setNumeric()
        } else if (isAlphaTo646ToAlphaLatch(current.position)) {
            if (current.position + 5 < this.information.size) {
                current.incrementPosition(5)
            } else {
                current.position = this.information.size
            }

            current.setAlpha()
        }
        BlockParsedResult()
    }