    public func getNextIncludedTime(timeStamp0: Int64 ) :Int64 {

        var  timeStamp = timeStamp0

        let baseTime = super.getNextIncludedTime(timeStamp);
        if ((baseTime > 0) && (baseTime > timeStamp)) {
            timeStamp = baseTime;
        }

        var day =  getStartOfDay(timeStamp);

        while (!isTimeIncluded(day.getTime()) ) {
            timeStamp += 24*60*60*1000
            day = toDateTime(timeStamp)
        }

        return timeStamp;
    }