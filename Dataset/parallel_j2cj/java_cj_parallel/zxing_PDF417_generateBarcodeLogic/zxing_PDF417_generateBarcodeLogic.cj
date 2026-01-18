    func generateBarcodeLogic(msg: String, errorCorrectionLevel: Int64, autoECI: Bool) {
        let errorCorrectionCodeWords = PDF417ErrorCorrection.getErrorCorrectionCodewordCount(errorCorrectionLevel)
        let highLevel = PDF417HighLevelEncoder.encodeHighLevel(msg, compaction, autoECI)
        let sourceCodeWords = highLevel.size

        let dimension = determineDimensions(sourceCodeWords, errorCorrectionCodeWords)

        let cols = dimension[0]
        let rows = dimension[1]

        let pad = getNumberOfPadCodewords(sourceCodeWords, errorCorrectionCodeWords, cols, rows)

        if (sourceCodeWords + errorCorrectionCodeWords + 1 > 929) {
            throw WriterException("Encoded message contains too many code words, message too big (${msg.size} bytes)")
        }

        let n = sourceCodeWords + pad + 1
        let sb = StringBuilder()
        sb.append(Char(n))
        sb.append(highLevel)
        for (i in 0..pad) {
            sb.append(Char(900))
        }
        let dataCodewords = sb.toString()
        let ec = PDF417ErrorCorrection.generateErrorCorrection(dataCodewords, errorCorrectionLevel)
        let bm = BarcodeMatrix(rows, cols)
        this.barcodeMatrix = bm
        encodeLowLevel(dataCodewords + ec, cols, rows, errorCorrectionLevel, bm)
    }
