    private func buildSnake(start: Int64, diag: Int64, end1: Int64, end2: Int64): Snake {
        var end = start
        while (end - diag < end2 && end < end1 && this.left.get(end) == this.right.get(end - diag)) {
            end++
        }
        return Snake(start, end, diag)
    }