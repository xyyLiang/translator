    func fillStarSparseData(headers: Map<String, String>): Unit {
        this.starSparse = true
        if (headers.contains("SCHILY.realsize")) {
            try {
                this.realSize = Int64.parse(headers["SCHILY.realsize"])
            } catch (ex: Exception) {
                throw  Exception("Corrupted TAR archive. SCHILY.realsize header for " + this.name + " contains non-numeric value")
            }
        }
    }