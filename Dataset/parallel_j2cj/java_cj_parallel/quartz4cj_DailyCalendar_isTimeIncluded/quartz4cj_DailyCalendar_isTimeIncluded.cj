    public func isTimeIncluded(timeInMillis: Int64) : Bool {

        if (!super.isTimeIncluded(timeInMillis)) { 
            return false; 
        }

        let startOfDayInMillis = getStartOfDay(timeInMillis).getTime()
        let endOfDayInMillis = getEndOfDay(timeInMillis).getTime()

        let timeRangeStartingTimeInMillis =  getTimeRangeStartingTimeInMillis(timeInMillis)
        let timeRangeEndingTimeInMillis =  getTimeRangeEndingTimeInMillis(timeInMillis)

        if (!invertTimeRange) {
            return  ((timeInMillis > startOfDayInMillis && 
                    timeInMillis < timeRangeStartingTimeInMillis) ||
                (timeInMillis > timeRangeEndingTimeInMillis && 
                    timeInMillis < endOfDayInMillis));
        } else {
            return ((timeInMillis >= timeRangeStartingTimeInMillis) &&
                    (timeInMillis <= timeRangeEndingTimeInMillis));
        }
    }