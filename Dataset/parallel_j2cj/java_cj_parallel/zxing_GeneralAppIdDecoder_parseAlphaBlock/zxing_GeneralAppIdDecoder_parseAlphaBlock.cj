    func parseAlphaBlock(): BlockParsedResult {
        while (isStillAlpha(current.position)) {
            let alpha = decodeAlphanumeric(current.position)
            current.position = alpha.newPosition

            if (alpha.isFNC1()) {
                let information = DecodedInformation(current.position, buffer.toString())
                return BlockParsedResult(information, true)
            }

            buffer.append(alpha.value)
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

            current.setIsoIec646()
        }
        BlockParsedResult()
    }