    private func getMonthNumber(s: String): Int64 {
        let integer = monthMap.get(s)
        return integer ?? -1 
    }