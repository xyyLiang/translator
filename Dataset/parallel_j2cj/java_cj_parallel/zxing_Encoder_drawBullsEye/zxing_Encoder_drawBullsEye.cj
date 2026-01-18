    static func drawBullsEye(matrix: BitMatrix, center: Int64, size: Int64) {
        for (i in 0..size : 2) {
            for (j in (center - i)..=(center + i)) {
                matrix.set(j, center - i)
                matrix.set(j, center + i)
                matrix.set(center - i, j)
                matrix.set(center + i, j)
            }
        }
        matrix.set(center - size, center - size)
        matrix.set(center - size + 1, center - size)
        matrix.set(center - size, center - size + 1)
        matrix.set(center + size, center - size)
        matrix.set(center + size, center - size + 1)
        matrix.set(center + size, center + size - 1)
    }