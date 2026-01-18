    public func withIntervalInMinutes(intervalInMinutes: Int64): CalendarIntervalScheduleBuilder {
        validateInterval(intervalInMinutes)
        this.interval = intervalInMinutes
        this.intervalUnit = IntervalUnit.MINUTE
        return this
    }    