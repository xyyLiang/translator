    static func adjustCodewordCount(detectionResult: DetectionResult, barcodeMatrix: Array<Array<BarcodeValue>>) {
        let barcodeMatrix01 = barcodeMatrix[0][1]
        let numberOfCodewords = barcodeMatrix01.getValue()
        let calculatedNumberOfCodewords = detectionResult.barcodeColumnCount * detectionResult.getBarcodeRowCount() -
            getNumberOfECCodeWords(detectionResult.getBarcodeECLevel())
        if (numberOfCodewords.size == 0) {
            if (calculatedNumberOfCodewords < 1 || calculatedNumberOfCodewords > PDF417Common.MAX_CODEWORDS_IN_BARCODE) {
                throw NotFoundException()
            }
            barcodeMatrix01.setValue(calculatedNumberOfCodewords)
        } else if (numberOfCodewords[0] != calculatedNumberOfCodewords && calculatedNumberOfCodewords >= 1 &&
            calculatedNumberOfCodewords <= PDF417Common.MAX_CODEWORDS_IN_BARCODE) {
            barcodeMatrix01.setValue(calculatedNumberOfCodewords)
        }
    }