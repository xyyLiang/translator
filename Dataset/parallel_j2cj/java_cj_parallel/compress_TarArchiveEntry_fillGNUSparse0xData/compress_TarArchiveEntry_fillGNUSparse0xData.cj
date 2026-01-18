    func fillGNUSparse0xData(headers: Map<String, String>): Unit {
        this.paxGNUSparse = true
        this.realSize = Int64.parse(headers["GNU.sparse.size"])
        if (headers.contains("GNU.sparse.name")) {
            this.name = headers["GNU.sparse.name"]
        }
    }