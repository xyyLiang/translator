    public override func triggered(calendar: ?Calendar): Unit {
        timesTriggered++
        previousFireTime = nextFireTime
        nextFireTime = getFireTimeAfter(nextFireTime)

        while (nextFireTime.isPresent() && calendar.isPresent() && !calendar.getOrThrow().isTimeIncluded(nextFireTime.getOrThrow().getTime())) {
            nextFireTime = getFireTimeAfter(nextFireTime)
            if(nextFireTime == None) {
                break
            }
            
            //avoid infinite loop
            if (nextFireTime.getOrThrow().year > TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT) {
                nextFireTime = None
            }
        }
        
        if (nextFireTime == None) {
            complete = true
        }
    }    