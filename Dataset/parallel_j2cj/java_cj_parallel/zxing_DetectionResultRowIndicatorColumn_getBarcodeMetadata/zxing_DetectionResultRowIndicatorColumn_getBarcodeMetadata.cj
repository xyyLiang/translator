    func getBarcodeMetadata(): ?BarcodeMetadata {
        let barcodeColumnCount = BarcodeValue()
        let barcodeRowCountUpperPart = BarcodeValue()
        let barcodeRowCountLowerPart = BarcodeValue()
        let barcodeECLevel = BarcodeValue()
        let codewords = this.codewords
        for (codeword in codewords) {
            if (let Some(c) = codeword) {
                c.setRowNumberAsRowIndicatorColumn()
                let rowIndicatorValue = c.value % 30
                var codewordRowNumber = c.rowNumber
                if (!isLeft) {
                    codewordRowNumber += 2
                }
                match (codewordRowNumber % 3) {
                    case 0 => barcodeRowCountUpperPart.setValue(rowIndicatorValue * 3 + 1)

                    case 1 =>
                        barcodeECLevel.setValue(rowIndicatorValue / 3)
                        barcodeRowCountLowerPart.setValue(rowIndicatorValue % 3)
                    case 2 => barcodeColumnCount.setValue(rowIndicatorValue + 1)
                    case _ => ()
                }
            }
        }
        if ((barcodeColumnCount.getValue().size == 0) || (barcodeRowCountUpperPart.getValue().size == 0) || (barcodeRowCountLowerPart.
        getValue().size == 0) || (barcodeECLevel.getValue().size == 0) || barcodeColumnCount.getValue()[0] < 1 ||
            barcodeRowCountUpperPart.getValue()[0] + barcodeRowCountLowerPart.getValue()[0] < PDF417Common.
        MIN_ROWS_IN_BARCODE || barcodeRowCountUpperPart.getValue()[0] + barcodeRowCountLowerPart.getValue()[0] >
            PDF417Common.MAX_ROWS_IN_BARCODE) {
            return None
        }
        let barcodeMetadata = BarcodeMetadata(
            barcodeColumnCount.getValue()[0],
            barcodeRowCountUpperPart.getValue()[0],
            barcodeRowCountLowerPart.getValue()[0],
            barcodeECLevel.getValue()[0]
        )
        removeIncorrectCodewords(codewords, barcodeMetadata)
        barcodeMetadata
    }