    private func advanceToNextDayOfWeekIfNecessary(fireTime0: DateTime, forceToAdvanceNextDay: Bool): ?DateTime {
        // a. Advance or adjust to next dayOfWeek if need to first, starting next day with startTimeOfDay.
        var fireTime = fireTime0
        var sTimeOfDay = getStartTimeOfDay()
        var fireTimeStartDate = sTimeOfDay.getTimeOfDayForDate(fireTime)      
        var fireTimeStartDateCal = createCalendarTime(fireTimeStartDate)          
        var dayOfWeekOfFireTime = fireTimeStartDateCal.get(Calendars.DAY_OF_WEEK)
        
        // b2. We need to advance to another day if isAfterTimePassEndTimeOfDay is true, or dayOfWeek is not set.
        var daysOfWeekToFire = getDaysOfWeek()
        if (forceToAdvanceNextDay || !daysOfWeekToFire.contains(dayOfWeekOfFireTime)) {
          // Advance one day at a time until next available date.
          for(_ in 1..=7) {
            fireTimeStartDateCal.add(Calendars.DAY_OF_MONTH, 1)
            dayOfWeekOfFireTime = fireTimeStartDateCal.get(Calendars.DAY_OF_WEEK)
            if (daysOfWeekToFire.contains(dayOfWeekOfFireTime)) {
              fireTime = fireTimeStartDateCal.getTime()
              break
            }
          }
        }
        
        // Check fireTime not pass the endTime
        var eTime = getEndTime()
        if (eTime.isPresent() && fireTime.getTime() >= eTime.getOrThrow().getTime()) {  // quartz 原有代码这里有 bug， endTime不能是最后一次触发时间
            return None
        }

        return fireTime
    }    