    private func getSet(types: Int64): QzTreeSet<Int64> {
        match (types) {
            case v where v == SECOND =>
                return seconds
            case v where v == MINUTE =>
                return minutes
            case v where v == HOUR =>
                return hours
            case v where v == DAY_OF_MONTH =>
                return daysOfMonth
            case v where v == MONTH =>
                return months
            case v where v == DAY_OF_WEEK =>
                return daysOfWeek
            case v where v == YEAR =>
                return years
            case _ => 
                throw Exception("Not supported types")
        }
    }  