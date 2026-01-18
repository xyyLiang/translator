    func validateQuietZone(row: BitArray, startPattern: Int64) {
        var quietCount = math.min(this.narrowLineWidth * 10, startPattern)

        for (i in (startPattern - 1)..0 : -1) {
            if (quietCount <= 0) {
                break
            }
            if (row.get(i)) {
                break
            }
            quietCount--
        }
        if (quietCount != 0) {
            throw NotFoundException()
        }
    }