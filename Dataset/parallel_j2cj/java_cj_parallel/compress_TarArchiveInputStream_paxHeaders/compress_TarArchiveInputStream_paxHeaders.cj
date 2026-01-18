    private func paxHeaders(): Unit {
        var sparseHeaders: ArrayList<TarArchiveStructSparse> = ArrayList<TarArchiveStructSparse>()
        let headers: Map<String, String> = TarUtils.parsePaxHeaders(this, sparseHeaders, this.globalPaxHeaders, this.entrySize)
        if (headers.contains("GNU.sparse.map")) {
            sparseHeaders = TarUtils.parseFromPAX01SparseHeaders(headers["GNU.sparse.map"])
        }
        this.getNextEntry()
        this.currEntry.getOrThrow({=>
            throw Exception("premature end of tar archive. Didn't find any entry after PAX header.")
        })
        this.applyPaxHeadersToCurrentEntry(headers, sparseHeaders)

        if (this.currEntry.getOrThrow().isPaxGNU1XSparse()) {
            sparseHeaders = TarUtils.parsePAX1XSparseHeaders(this.inputStream, this.recordSize)
            this.currEntry.getOrThrow().setSparseHeaders(sparseHeaders)
        }

        this.buildSparseInputStreams()
    }