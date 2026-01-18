    public func getNextIncludedTime(timeStamp0: Int64 ) :Int64 {

        var  timeStamp = timeStamp0

        if (excludeAll) {
            return 0;
        }

        let baseTime = super.getNextIncludedTime(timeStamp);
        if ((baseTime > 0) && (baseTime > timeStamp)) {
            timeStamp = baseTime;
        }

        let dt = toDateTime(timeStamp)
        var wday = dt.dayOfWeek

        if (!isDayExcluded(wday)) {
            return timeStamp; // return the original value
        }

        while (isDayExcluded(wday) ) {
            timeStamp += 24*60*60*1000
            let dt = toDateTime(timeStamp)
            wday = dt.dayOfWeek
        }

        return timeStamp;
    }