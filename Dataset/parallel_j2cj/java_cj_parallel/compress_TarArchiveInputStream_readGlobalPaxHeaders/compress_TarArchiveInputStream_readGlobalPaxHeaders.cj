    private func readGlobalPaxHeaders(): Unit {
        this.globalPaxHeaders = TarUtils.parsePaxHeaders(this, this.globalSparseHeaders, this.globalPaxHeaders, this.entrySize)
        this.getNextEntry()

        match(this.currEntry) {
            case None => throw Exception("Error detected parsing the pax header")
            case _ => ()
        }
    }