    public func withIntervalInHours(intervalInHours: Int64): CalendarIntervalScheduleBuilder {
        validateInterval(intervalInHours)
        this.interval = intervalInHours
        this.intervalUnit = IntervalUnit.HOUR
        return this
    }   