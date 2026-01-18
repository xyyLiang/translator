    public override func computeFirstFireTime(calendar: ?Calendar): ?DateTime {
        var dateTime = getStartTime().addSeconds(-1)
        nextFireTime = getFireTimeAfter(dateTime)
      
        // Check calendar for date-time exclusion
        while (nextFireTime != None && calendar.isPresent() && !calendar.getOrThrow().isTimeIncluded(nextFireTime.getOrThrow().getTime())) {
            nextFireTime = getFireTimeAfter(nextFireTime)
            if(nextFireTime == None) {
                break
            }
        
            //avoid infinite loop
            if (nextFireTime.getOrThrow().year  > TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT) {
                return None
            }
        }
        
        return nextFireTime
    }