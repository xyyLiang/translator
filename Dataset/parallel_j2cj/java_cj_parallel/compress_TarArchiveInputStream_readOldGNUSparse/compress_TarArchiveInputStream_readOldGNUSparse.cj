    private func readOldGNUSparse(): Unit {
        if (this.currEntry.getOrThrow().isExtendedFollows()) {
            var entry: ?TarArchiveSparseEntry = None
            do {
                let headerBuf: ?Array<Byte> = this.getRecord()
                if (headerBuf == None) {
                    throw Exception("premature end of tar archive. Didn't find extended_header after header with extended flag.")
                }
                entry = TarArchiveSparseEntry(headerBuf.getOrThrow())
                this.currEntry.getOrThrow().getSparseHeaders().appendAll(entry.getOrThrow().getSparseHeaders())
            } while (entry.getOrThrow().isExtendedFollows())
        }

        this.buildSparseInputStreams()
    }