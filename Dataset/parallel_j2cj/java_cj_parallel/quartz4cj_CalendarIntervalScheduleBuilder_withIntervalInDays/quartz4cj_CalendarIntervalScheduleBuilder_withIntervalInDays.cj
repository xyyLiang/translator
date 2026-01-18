    public func withIntervalInDays(intervalInDays: Int64): CalendarIntervalScheduleBuilder {
        validateInterval(intervalInDays)
        this.interval = intervalInDays
        this.intervalUnit = IntervalUnit.DAY
        return this
    }  