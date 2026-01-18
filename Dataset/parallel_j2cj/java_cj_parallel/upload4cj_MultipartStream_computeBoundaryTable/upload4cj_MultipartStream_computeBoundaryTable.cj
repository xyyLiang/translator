    private func computeBoundaryTable() {
        var cjPosition: Int64 = 2
        var candidate: Int64 = 0

        boundaryTable[0] = -1
        boundaryTable[1] = 0

        while (cjPosition <= boundaryLength) {
            if (boundary[cjPosition - 1] == boundary[candidate]) {
                boundaryTable[cjPosition] = candidate + 1
                candidate++
                cjPosition++
            } else if (candidate > 0) {
                candidate = boundaryTable[candidate]
            } else {
                boundaryTable[cjPosition] = 0
                cjPosition++
            }
        }
    }