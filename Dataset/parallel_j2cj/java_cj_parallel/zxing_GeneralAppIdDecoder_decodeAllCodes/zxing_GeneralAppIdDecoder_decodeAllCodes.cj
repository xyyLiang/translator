    func decodeAllCodes(buff: StringBuilder, initialPosition: Int64): String {
        var currentPosition = initialPosition
        var remaining: ?String = None
        do {
            let info = this.decodeGeneralPurposeField(currentPosition, remaining)
            let parsedFields = FieldParser.parseFieldsInGeneralPurpose(info.newString)
            if (let Some(p) = parsedFields) {
                buff.append(p)
            }
            if (info.remaining) {
                remaining = "${info.remainingValue}"
            } else {
                remaining = None
            }

            if (currentPosition == info.newPosition) {
                break
            }
            currentPosition = info.newPosition
        } while (true)

        return buff.toString()
    }