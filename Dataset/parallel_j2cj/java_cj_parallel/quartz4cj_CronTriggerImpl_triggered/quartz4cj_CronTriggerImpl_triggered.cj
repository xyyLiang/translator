    public override func triggered(calendar: ?Calendar): Unit {
        previousFireTime = nextFireTime
        nextFireTime = getFireTimeAfter(nextFireTime)

        while (nextFireTime.isPresent() && calendar.isPresent() && !calendar.getOrThrow().isTimeIncluded(nextFireTime.getOrThrow().getTime())) {
            nextFireTime = getFireTimeAfter(nextFireTime)
        }
    } 