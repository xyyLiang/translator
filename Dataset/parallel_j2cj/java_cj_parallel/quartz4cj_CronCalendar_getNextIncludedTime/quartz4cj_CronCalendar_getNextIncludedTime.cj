    public func getNextIncludedTime(timeInMillis: Int64 ) :Int64 {

        var nextIncludedTime = timeInMillis + 1;
        
        while (!isTimeIncluded(nextIncludedTime)) {

            // If the time is in a range excluded by this calendar, we can
            // move to the end of the excluded time range and continue testing
            // from there. Otherwise, if nextIncludedTime is excluded by the
            // baseCalendar, ask it the next time it includes and begin testing
            // from there. Failing this, add one millisecond and continue
            // testing.

            let dt = toDateTime(nextIncludedTime)
            if (cronExpression.isSatisfiedBy(dt)) {
                nextIncludedTime = cronExpression.getNextInvalidTimeAfter(dt).getTime();
            } else if ( baseCalendar.isPresent() && !baseCalendar.getOrThrow().isTimeIncluded(nextIncludedTime) ){
                nextIncludedTime = baseCalendar.getOrThrow().getNextIncludedTime(nextIncludedTime);
            } else {
                nextIncludedTime++;
            }
        }
        
        return nextIncludedTime;
    }