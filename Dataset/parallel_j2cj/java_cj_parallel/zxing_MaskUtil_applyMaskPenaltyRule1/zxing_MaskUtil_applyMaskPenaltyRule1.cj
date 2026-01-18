func applyMaskPenaltyRule1(matrix: ByteMatrix): Int64 {
    applyMaskPenaltyRule1Internal(matrix, true) + applyMaskPenaltyRule1Internal(matrix, false)
}