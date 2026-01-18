    private func buildSparseInputStreams(): Unit {
        this.currentSparseInputStreamIndex = -1
        this.sparseInputStreams = ArrayList<InputStream>()

        let sparseHeaders: Array<TarArchiveStructSparse> = this.currEntry.getOrThrow().getOrderedSparseHeaders()

        let zeroInputStream: InputStream = TarArchiveSparseZeroInputStream()
        var offset: Int64 = 0
        for (sparseHeader in sparseHeaders) {
            let zeroBlockSize: Int64 = sparseHeader.getOffset() - offset
            if (zeroBlockSize < 0) {
                throw Exception("Corrupted struct sparse detected")
            }

            if (zeroBlockSize > 0) {
                this.sparseInputStreams.append(BoundedInputStream(zeroInputStream, sparseHeader.getOffset() - offset))
            }

            if (sparseHeader.getNumbytes() > 0) {
                this.sparseInputStreams.append(BoundedInputStream(this.inputStream, sparseHeader.getNumbytes()))
            }

            offset = sparseHeader.getOffset() + sparseHeader.getNumbytes()
        }

        if (this.sparseInputStreams.size != 0) {
            this.currentSparseInputStreamIndex = 0
        }
    }