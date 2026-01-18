    public func setStartTime(startTime0: DateTime): Unit {
        let startTime = startTime0.inTimeZone(getTimeZone())

        var eTime = getEndTime()
        if (eTime != None && eTime.getOrThrow() < startTime) {
            throw IllegalArgumentException("End time cannot be before start time")
        }
        
        // round off millisecond...
        // Note timeZone is not needed here as parameter for
        // Calendar.getInstance(),
        // since time zone is implicit when using a Date in the setTime method.
        var cl = Calendars.getInstance(getTimeZone())
        cl.setTime(startTime)
        cl.set(Calendars.MILLISECOND, 0)

        this.startTime = cl.getTime()
    }