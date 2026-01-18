    func fillGNUSparse1xData(headers: Map<String, String>): Unit {
        this.paxGNUSparse = true
        this.paxGNU1XSparse = true
        if (headers.contains("GNU.sparse.name")) {
            this.name = headers["GNU.sparse.name"]
        }
        if (headers.contains("GNU.sparse.realsize")) {
            try {
                this.realSize = Int64.parse(headers["GNU.sparse.realsize"])
            } catch (ex:Exception) {
                throw  Exception("Corrupted TAR archive. GNU.sparse.realsize header for ${this.name} contains non-numeric value")
            }
        }
    }