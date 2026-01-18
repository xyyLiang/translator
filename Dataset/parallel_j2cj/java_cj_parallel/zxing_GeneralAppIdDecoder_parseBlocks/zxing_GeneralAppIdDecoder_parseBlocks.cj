    func parseBlocks(): ?DecodedInformation {
        var isFinished = false
        var result: BlockParsedResult = BlockParsedResult()
        do {
            let initialPosition = current.position

            isFinished = if (current.isAlpha()) {
                result = parseAlphaBlock()
                result.finished
            } else if (current.isIsoIec646()) {
                result = parseIsoIec646Block()
                result.finished
            } else {
                result = parseNumericBlock()
                result.finished
            }

            let positionChanged = initialPosition != current.position
            if (!positionChanged && !isFinished) {
                break
            }
        } while (!isFinished)

        result.decodedInformation
    }