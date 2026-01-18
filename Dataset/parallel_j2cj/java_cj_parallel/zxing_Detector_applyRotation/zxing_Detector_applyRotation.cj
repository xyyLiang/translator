    static func applyRotation(matrix: BitMatrix, rotation: Int64): BitMatrix {
        if (rotation % 360 == 0) {
            return matrix
        }

        let newMatrix = matrix.clone()
        newMatrix.rotate(rotation)
        newMatrix
    }