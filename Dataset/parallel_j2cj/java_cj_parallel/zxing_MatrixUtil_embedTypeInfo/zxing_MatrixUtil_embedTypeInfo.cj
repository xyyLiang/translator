func embedTypeInfo(ecLevel: ErrorCorrectionLevel, maskPattern: Int64, matrix: ByteMatrix) {
    let typeInfoBits = BitArray()
    makeTypeInfoBits(ecLevel, maskPattern, typeInfoBits)

    for (i in 0..typeInfoBits.size) {
        let bit = typeInfoBits.get(typeInfoBits.size - 1 - i)

        let coordinates = TYPE_INFO_COORDINATES[i]
        var x1 = coordinates[0]
        var y1 = coordinates[1]
        matrix.set(x1, y1, bit)

        let (x2, y2) = if (i < 8) {
            (matrix.width - i - 1, 8)
        } else {
            (8, matrix.height - 7 + (i - 8))
        }
        matrix.set(x2, y2, bit)
    }
}
