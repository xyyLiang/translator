    public func withIntervalInSeconds(intervalInSeconds: Int64): CalendarIntervalScheduleBuilder {
        validateInterval(intervalInSeconds)
        this.interval = intervalInSeconds
        this.intervalUnit = IntervalUnit.SECOND
        return this
    }    