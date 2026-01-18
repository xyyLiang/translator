    public func endingDailyAfterCount(count: Int64): DailyTimeIntervalScheduleBuilder {
        if(count <= 0) {
            throw IllegalArgumentException("Ending daily after count must be a positive number!")
        }
        
        if(!startTimeOfDay.isPresent()) {
            throw IllegalArgumentException("You must set the startDailyAt() before calling this endingDailyAfterCount()!")
        }
        
        let today = DateTime.now()
        let startTimeOfDayDate = startTimeOfDay.getOrThrow().getTimeOfDayForDate(today)
        let maxEndTimeOfDayDate = TimeOfDay.hourMinuteAndSecondOfDay(23, 59, 59).getTimeOfDayForDate(today)
        let remainingMillisInDay = maxEndTimeOfDayDate.getTime() - startTimeOfDayDate.getTime()

        var intervalInMillis: Int64 = 0
        if (intervalUnit == IntervalUnit.SECOND) {
            intervalInMillis = interval * 1000
        } else if (intervalUnit == IntervalUnit.MINUTE) {
            intervalInMillis = interval * 1000 * 60
        } else if (intervalUnit == IntervalUnit.HOUR) {
            intervalInMillis = interval * 1000 * 60 * 24
        } else {
            throw IllegalArgumentException("The IntervalUnit: ${intervalUnit} is invalid for this trigger.") 
        }
        
        if (remainingMillisInDay - intervalInMillis <= 0) {
            throw IllegalArgumentException("The startTimeOfDay is too late with given Interval and IntervalUnit values.")
        }
        
        let maxNumOfCount = (remainingMillisInDay / intervalInMillis)
        if (count > maxNumOfCount) {
            throw IllegalArgumentException("The given count ${count} is too large! The max you can set is ${maxNumOfCount}")
        }
        
        let incrementInMillis = (count - 1) * intervalInMillis
        let endTimeOfDayDate = DateTime.fromUnixTimeStampWithTimeZone(startTimeOfDayDate.getTime() + incrementInMillis)      
        
        if (endTimeOfDayDate > maxEndTimeOfDayDate) {
            throw IllegalArgumentException("The given count ${count} is too large! The max you can set is ${maxNumOfCount}")
        }
        
        let cal = Calendars.getInstance()
        cal.setTime(endTimeOfDayDate)
        var hour = cal.get(Calendars.HOUR_OF_DAY)
        var minute = cal.get(Calendars.MINUTE)
        var second = cal.get(Calendars.SECOND)
        
        endTimeOfDay = TimeOfDay.hourMinuteAndSecondOfDay(hour, minute, second)
        return this
    }   