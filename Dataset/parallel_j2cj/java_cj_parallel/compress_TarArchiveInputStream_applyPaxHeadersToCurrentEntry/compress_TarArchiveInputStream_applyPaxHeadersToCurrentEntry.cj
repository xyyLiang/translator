    private func applyPaxHeadersToCurrentEntry(headers: Map<String, String>, sparseHeaders: ArrayList<TarArchiveStructSparse>): Unit {
        this.currEntry.getOrThrow().updateEntryFromPaxHeaders(headers)
        this.currEntry.getOrThrow().setSparseHeaders(sparseHeaders)
    }