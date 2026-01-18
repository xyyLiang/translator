    func encodeCompressedDate(buf: StringBuilder, currentPos: Int64) {
        var numericDate = this.generalDecoder.extractNumericValueFromBitArray(currentPos, DATE_SIZE)
        if (numericDate == 38400) {
            return
        }

        buf.append('(')
        buf.append(this.dateCode)
        buf.append(')')

        let day = numericDate % 32
        numericDate /= 32
        let month = numericDate % 12 + 1
        numericDate /= 12
        let year = numericDate

        if (year / 10 == 0) {
            buf.append('0')
        }
        buf.append(year)
        if (month / 10 == 0) {
            buf.append('0')
        }
        buf.append(month)
        if (day / 10 == 0) {
            buf.append('0')
        }
        buf.append(day)
    }