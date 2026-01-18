func isWhiteVertical(array: Array<Array<Int64>>, col: Int64, fro: Int64, to: Int64): Bool {
    if (fro < 0 || array.size < to) {
        return false
    }
    for (i in fro..to) {
        if (array[i][col] == 1) {
            return false
        }
    }
    true
}