    func encodeLowLevel(fullCodewords: String, c: Int64, r: Int64, errorCorrectionLevel: Int64, logic: BarcodeMatrix) {
        var idx = 0
        for (y in 0..r) {
            let cluster = y % 3
            logic.startRow()
            encodeChar(START_PATTERN, 17, logic.getCurrentRow())

            let (left, right) = if (cluster == 0) {
                ((30 * (y / 3)) + ((r - 1) / 3), (30 * (y / 3)) + (c - 1))
            } else if (cluster == 1) {
                ((30 * (y / 3)) + (errorCorrectionLevel * 3) + ((r - 1) % 3), (30 * (y / 3)) + ((r - 1) / 3))
            } else {
                ((30 * (y / 3)) + (c - 1), (30 * (y / 3)) + (errorCorrectionLevel * 3) + ((r - 1) % 3))
            }

            var pattern = CODEWORD_TABLE[cluster][left]
            encodeChar(pattern, 17, logic.getCurrentRow())

            for (x in 0..c) {
                pattern = CODEWORD_TABLE[cluster][Int64(UInt32(fullCodewords.charAt(idx)))]
                encodeChar(pattern, 17, logic.getCurrentRow())
                idx++
            }

            if (compact) {
                encodeChar(STOP_PATTERN, 1, logic.getCurrentRow())
            } else {
                pattern = CODEWORD_TABLE[cluster][right]
                encodeChar(pattern, 17, logic.getCurrentRow())

                encodeChar(STOP_PATTERN, 18, logic.getCurrentRow())
            }
        }
    }