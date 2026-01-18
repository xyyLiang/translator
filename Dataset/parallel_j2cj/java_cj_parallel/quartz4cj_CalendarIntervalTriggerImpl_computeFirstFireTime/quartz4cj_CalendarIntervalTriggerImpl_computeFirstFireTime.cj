    public func computeFirstFireTime(calendar: ?Calendar): ?DateTime {
        nextFireTime = getStartTime()

        while (nextFireTime != None && calendar.isPresent() && !calendar.getOrThrow().isTimeIncluded(nextFireTime.getOrThrow().getTime())) {
            nextFireTime = getFireTimeAfter(nextFireTime)
            if(nextFireTime == None) {
                break
            }
            
            //avoid infinite loop
            if(nextFireTime.getOrThrow().year > TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT) {
                return None
            }            
        }
        
        return nextFireTime
    }   