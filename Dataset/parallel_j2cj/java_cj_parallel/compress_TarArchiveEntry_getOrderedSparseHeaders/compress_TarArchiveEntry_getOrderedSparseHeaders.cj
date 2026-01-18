    public func getOrderedSparseHeaders(): Array<TarArchiveStructSparse> {
        match (this.sparseHeaders) {
            case None => return Array<TarArchiveStructSparse>()
            case Some(v) => 
                if (v.size == 0) {
                    return Array<TarArchiveStructSparse>()
                }
        }
        let getRawArray: Array<TarArchiveStructSparse> = unsafe {this.sparseHeaders.getOrThrow().getRawArray()}
        let orderedAndFiltered = ArrayList<TarArchiveStructSparse>()
        for (item in getRawArray where (item.getOffset() > 0 || item.getNumbytes() > 0)) {
            orderedAndFiltered.append(item)
        }
        orderedAndFiltered.sortBy({R: TarArchiveStructSparse, L: TarArchiveStructSparse =>
            if (R.getOffset() < L.getOffset()) {
                return Ordering.LT
            } else if(R.getOffset() > L.getOffset()) {
                return Ordering.GT
            } else {
                return Ordering.EQ
            }
        })

        let numberOfHeaders: Int64 = orderedAndFiltered.size
        var i = 0
        while (i < numberOfHeaders) {
            let str: TarArchiveStructSparse = orderedAndFiltered[i]
            if (i + 1 < numberOfHeaders && str.getOffset() + str.getNumbytes() > orderedAndFiltered[i + 1].getOffset()) {
                throw Exception("Corrupted TAR archive. Sparse blocks for ${this.getName()} overlap each other.")
            }
            if (str.getOffset() + str.getNumbytes() < 0) {
                throw Exception("Unreadable TAR archive. Offset and numbytes for sparse block in ${this.getName()} too large.")
            }
            i++
        }
        if (orderedAndFiltered.size != 0) {
            let last: TarArchiveStructSparse = orderedAndFiltered[numberOfHeaders - 1]
            if (last.getOffset() + last.getNumbytes() > getRealSize()) {
                throw Exception("Corrupted TAR archive. Sparse block extends beyond real size of the entry")
            }
        }
        return unsafe {orderedAndFiltered.getRawArray()}
    }
