    private func getDayOfWeekNumber(s: String): Int64 {
        let integer = dayMap.get(s)
        return integer ?? -1
    }