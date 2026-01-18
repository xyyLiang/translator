    public override func computeFirstFireTime(calendar: ?Calendar): ?DateTime {
        let dateTime = getStartTime().addSeconds(-1)
        nextFireTime = getFireTimeAfter(dateTime)

        while (nextFireTime != None && calendar.isPresent() && !calendar.getOrThrow().isTimeIncluded(nextFireTime.getOrThrow().getTime())) {
            nextFireTime = getFireTimeAfter(nextFireTime)
        }

        return nextFireTime
    }  