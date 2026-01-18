    @Override
    public Date getFireTimeAfter(Date afterTime) {
        // Check if trigger has completed or not.
        if (complete) {
            return null;
        }
        
        // Check repeatCount limit
        if (repeatCount != REPEAT_INDEFINITELY && timesTriggered > repeatCount) {
          return null;
        }
      
        // a. Increment afterTime by a second, so that we are comparing against a time after it!
        if (afterTime == null) {
          afterTime = new Date(System.currentTimeMillis() + 1000L);
        } else {
          afterTime = new Date(afterTime.getTime() + 1000L);
        }
         
        // make sure afterTime is at least startTime
        if(afterTime.before(startTime))
          afterTime = startTime;

        // b.Check to see if afterTime is after endTimeOfDay or not. If yes, then we need to advance to next day as well.
        boolean afterTimePastEndTimeOfDay = false;
        if (endTimeOfDay != null) {
          afterTimePastEndTimeOfDay = afterTime.getTime() > endTimeOfDay.getTimeOfDayForDate(afterTime).getTime();
        }
        // c. now we need to move move to the next valid day of week if either: 
        // the given time is past the end time of day, or given time is not on a valid day of week
        Date fireTime = advanceToNextDayOfWeekIfNecessary(afterTime, afterTimePastEndTimeOfDay);
        if (fireTime == null)
          return null;
                
        // d. Calculate and save fireTimeEndDate variable for later use
        Date fireTimeEndDate = null;
        if (endTimeOfDay == null)
          fireTimeEndDate = new TimeOfDay(23, 59, 59).getTimeOfDayForDate(fireTime);
        else
          fireTimeEndDate = endTimeOfDay.getTimeOfDayForDate(fireTime);
        
        // e. Check fireTime against startTime or startTimeOfDay to see which go first.
        Date fireTimeStartDate = startTimeOfDay.getTimeOfDayForDate(fireTime);
        if (fireTime.before(fireTimeStartDate)) {
          return fireTimeStartDate;
        } 
        
        
        // f. Continue to calculate the fireTime by incremental unit of intervals.
        // recall that if fireTime was less that fireTimeStartDate, we didn't get this far
        long fireMillis = fireTime.getTime();
        long startMillis = fireTimeStartDate.getTime();
        long secondsAfterStart = (fireMillis - startMillis) / 1000L;
        long repeatLong = getRepeatInterval();
        Calendar sTime = createCalendarTime(fireTimeStartDate);
        IntervalUnit repeatUnit = getRepeatIntervalUnit();
        if(repeatUnit.equals(IntervalUnit.SECOND)) {
            long jumpCount = secondsAfterStart / repeatLong;
            if(secondsAfterStart % repeatLong != 0)
                jumpCount++;
            sTime.add(Calendar.SECOND, getRepeatInterval() * (int)jumpCount);
            fireTime = sTime.getTime();
        } else if(repeatUnit.equals(IntervalUnit.MINUTE)) {
            long jumpCount = secondsAfterStart / (repeatLong * 60L);
            if(secondsAfterStart % (repeatLong * 60L) != 0)
                jumpCount++;
            sTime.add(Calendar.MINUTE, getRepeatInterval() * (int)jumpCount);
            fireTime = sTime.getTime();
        } else if(repeatUnit.equals(IntervalUnit.HOUR)) {
            long jumpCount = secondsAfterStart / (repeatLong * 60L * 60L);
            if(secondsAfterStart % (repeatLong * 60L * 60L) != 0)
                jumpCount++;
            sTime.add(Calendar.HOUR_OF_DAY, getRepeatInterval() * (int)jumpCount);
            fireTime = sTime.getTime();
        }
        
        // g. Ensure this new fireTime is within the day, or else we need to advance to next day.
        if (fireTime.after(fireTimeEndDate)) {
          fireTime = advanceToNextDayOfWeekIfNecessary(fireTime, isSameDay(fireTime, fireTimeEndDate));
          // make sure we hit the startTimeOfDay on the new day
          fireTime = startTimeOfDay.getTimeOfDayForDate(fireTime);
        }
    
        // i. Return calculated fireTime.
        return fireTime;
    }
