   private func checkIncrementRange(incr: Int64, types: Int64, idxPos: Int64): Unit {
        if (incr > 59 && (types == SECOND || types == MINUTE)) {
            throw ParseException("Increment >= 60 : ${incr}", idxPos)
        } else if (incr > 23 && (types == HOUR)) {
            throw ParseException("Increment >= 24 : ${incr}", idxPos)
        } else if (incr > 31 && (types == DAY_OF_MONTH)) {
            throw ParseException("Increment > 31 : ${incr}", idxPos)
        } else if (incr > 7 && (types == DAY_OF_WEEK)) {
            throw ParseException("Increment > 7 : ${incr}", idxPos)
        } else if (incr > 12 && (types == MONTH)) {
            throw ParseException("Increment > 12 : ${incr}", idxPos)
        }
    }