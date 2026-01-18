    public override func getFireTimeAfter(afterTime0: ?DateTime): ?DateTime {
        // Check if trigger has completed or not.
        if (complete) {
            return None
        }
        
        // Check repeatCount limit
        if (repeatCount != REPEAT_INDEFINITELY && timesTriggered > repeatCount) {
            return None
        }
      
        // a. Increment afterTime by a second, so that we are comparing against a time after it!
        var afterTime = ( afterTime0 ?? DateTime.now() ).addSeconds(1)
         
        // make sure afterTime is at least startTime
        if(afterTime < startTime) {
            afterTime = startTime
        }

        // b.Check to see if afterTime is after endTimeOfDay or not. If yes, then we need to advance to next day as well.
        var afterTimePastEndTimeOfDay = false
        if (endTimeOfDay.isPresent()) {
            afterTimePastEndTimeOfDay = afterTime > endTimeOfDay.getOrThrow().getTimeOfDayForDate(afterTime)
        }

        // c. now we need to move move to the next valid day of week if either: 
        // the given time is past the end time of day, or given time is not on a valid day of week
        var fireTime0 = advanceToNextDayOfWeekIfNecessary(afterTime, afterTimePastEndTimeOfDay)
        var fireTime = fireTime0 ?? return None

        // d. Calculate and save fireTimeEndDate variable for later use
        var fireTimeEndDate:DateTime
        if (!endTimeOfDay.isPresent()) {
            fireTimeEndDate = TimeOfDay(23, 59, 59).getTimeOfDayForDate(fireTime)
        } else {
            fireTimeEndDate = endTimeOfDay.getOrThrow().getTimeOfDayForDate(fireTime)
        }

        // e. Check fireTime against startTime or startTimeOfDay to see which go first.
        var fireTimeStartDate = startTimeOfDay.getTimeOfDayForDate(fireTime)
        if (fireTime < fireTimeStartDate) {
          return fireTimeStartDate
        } 
        
        // f. Continue to calculate the fireTime by incremental unit of intervals.
        // recall that if fireTime was less that fireTimeStartDate, we didn't get this far
        var fireMillis: Int64 = fireTime.getTime()
        var startMillis: Int64 = fireTimeStartDate.getTime()
        var secondsAfterStart: Int64 = (fireMillis - startMillis) / 1000
        var repeatLong: Int64 = getRepeatInterval()
        var repeatUnit = getRepeatIntervalUnit()

        var sTime = createCalendarTime(fireTimeStartDate)

        if(repeatUnit == IntervalUnit.SECOND) {
            var jumpCount: Int64 = secondsAfterStart / repeatLong
            if(secondsAfterStart % repeatLong != 0) {
                jumpCount++
            }
            sTime.add(Calendars.SECOND, getRepeatInterval() * jumpCount)
            fireTime = sTime.getTime()
        } else if(repeatUnit == IntervalUnit.MINUTE) {
            var jumpCount: Int64 = secondsAfterStart / (repeatLong * 60)
            if(secondsAfterStart % (repeatLong * 60) != 0) {
                jumpCount++
            }
            sTime.add(Calendars.MINUTE, getRepeatInterval() * jumpCount)
            fireTime = sTime.getTime()
        } else if(repeatUnit == IntervalUnit.HOUR) {
            var jumpCount: Int64 = secondsAfterStart / (repeatLong * 60 * 60)
            if(secondsAfterStart % (repeatLong * 60 * 60) != 0){
                jumpCount++
            }
            sTime.add(Calendars.HOUR_OF_DAY, getRepeatInterval() * jumpCount)
            fireTime = sTime.getTime()
        }
        
        // g. Ensure this new fireTime is within the day, or else we need to advance to next day.
        if (fireTime > fireTimeEndDate) {
          let fireTime1 = advanceToNextDayOfWeekIfNecessary(fireTime, isSameDay(fireTime, fireTimeEndDate))
          fireTime = fireTime1 ?? return None
          // make sure we hit the startTimeOfDay on the new day
          fireTime = startTimeOfDay.getTimeOfDayForDate(fireTime)
        }
    
        // quartz 原有代码这里有 bug, endTime不能是最后一次触发时间，已修复
        let eTime = getEndTime()
        if ( eTime.isPresent()  && fireTime >= eTime.getOrThrow() ) {
            return None
        }

        // i. Return calculated fireTime.
        return fireTime
    } 