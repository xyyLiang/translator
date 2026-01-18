func isWhiteHorizontal(rowArray: Array<Int64>, fro: Int64, to: Int64): Bool {
    if (fro < 0 || rowArray.size < to) {
        return false
    }
    for (i in fro..to) {
        if (rowArray[i] == 1) {
            return false
        }
    }
    true
}