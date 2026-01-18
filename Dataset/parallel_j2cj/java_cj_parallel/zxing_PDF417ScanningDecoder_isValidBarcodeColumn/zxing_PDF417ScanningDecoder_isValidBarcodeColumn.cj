    static func isValidBarcodeColumn(detectionResult: DetectionResult, barcodeColumn: Int64): Bool {
        barcodeColumn >= 0 && barcodeColumn <= detectionResult.barcodeColumnCount + 1
    }