    public override func updateWithNewCalendar(calendar: ?Calendar, misfireThreshold: Int64): Unit {
        nextFireTime = getFireTimeAfter(previousFireTime)
        if (nextFireTime == None || !calendar.isPresent() ) {
            return
        }
        
        var now = DateTime.now(timeZone: getTimeZone())
        while (nextFireTime != None && !calendar.getOrThrow().isTimeIncluded(nextFireTime.getOrThrow().getTime())) {
            nextFireTime = getFireTimeAfter(nextFireTime)
            if(nextFireTime == None) {
                break
            }
            
            // avoid infinite loop
            if (nextFireTime.getOrThrow().year > TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT) {
                nextFireTime = None
            }
            
            if(nextFireTime != None && nextFireTime.getOrThrow() < now) {
                var diff: Int64 = now.getTime() - nextFireTime.getOrThrow().getTime()
                if(diff >= misfireThreshold) {
                    nextFireTime = getFireTimeAfter(nextFireTime)
                }
            }
        }
    }    