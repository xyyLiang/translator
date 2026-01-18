    func removeIncorrectCodewords(codewords: Array<?Codeword>, barcodeMetadata: BarcodeMetadata) {
        for (codewordRow in 0..codewords.size) {
            if (let Some(codeword) = codewords[codewordRow]) {
                let rowIndicatorValue = codeword.value % 30
                var codewordRowNumber = codeword.rowNumber
                if (codewordRowNumber > barcodeMetadata.rowCount) {
                    codewords[codewordRow] = None
                    continue
                }
                if (!isLeft) {
                    codewordRowNumber += 2
                }
                match (codewordRowNumber % 3) {
                    case 0 =>
                        if (rowIndicatorValue * 3 + 1 != barcodeMetadata.rowCountUpperPart) {
                            codewords[codewordRow] = None
                        }
                    case 1 =>
                        if (rowIndicatorValue / 3 != barcodeMetadata.errorCorrectionLevel || rowIndicatorValue % 3 !=
                            barcodeMetadata.rowCountLowerPart) {
                            codewords[codewordRow] = None
                        }
                    case 2 =>
                        if (rowIndicatorValue + 1 != barcodeMetadata.columnCount) {
                            codewords[codewordRow] = None
                        }
                    case _ => ()
                }
            }
        }
    }