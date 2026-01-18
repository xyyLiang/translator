    public func getNextIncludedTime(timeStamp0: Int64) :Int64 {

        var  timeStamp = timeStamp0

        let baseTime = super.getNextIncludedTime(timeStamp);
        if ((baseTime > 0) && (baseTime > timeStamp)) {
            timeStamp = baseTime;
        }

        // Get timestamp for 00:00:00
        var day = getStartOfDay(timeStamp);
        if (!isDayExcluded(day)) { 
            return timeStamp; // return the original value
        }

        while (isDayExcluded(day)) {
            day = day.addDays(1)
        }

        return day.getTime()
    }