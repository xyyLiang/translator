    static func detect(image: BinaryBitmap, hints: ?HashMap<DecodeHintType, Any>, multiple: Bool): PDF417DetectorResult {
        let originalMatrix = image.blackMatrix()
        for (rotation in ROTATIONS) {
            let bitMatrix = applyRotation(originalMatrix, rotation)
            let barcodeCoordinates = detect(multiple, bitMatrix)
            if (!barcodeCoordinates.isEmpty()) {
                return PDF417DetectorResult(bitMatrix, barcodeCoordinates, rotation)
            }
        }
        return PDF417DetectorResult(originalMatrix, ArrayList<Array<?ResultPoint>>(), 0)
    }