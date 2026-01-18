    func decodeGeneralPurposeField(pos: Int64, remaining: ?String): DecodedInformation {
        this.buffer.clear()

        if (let Some(r) = remaining) {
            this.buffer.append(r)
        }

        this.current.position = pos

        let lastDecoded = parseBlocks()
        if (let Some(l) = lastDecoded) {
            if (l.remaining) {
                return DecodedInformation(
                    this.current.position,
                    this.buffer.toString(),
                    l.remainingValue
                )
            }
        }
        DecodedInformation(this.current.position, this.buffer.toString())
    }