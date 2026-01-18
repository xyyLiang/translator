    public func withIntervalInWeeks(intervalInWeeks: Int64): CalendarIntervalScheduleBuilder {
        validateInterval(intervalInWeeks)
        this.interval = intervalInWeeks
        this.intervalUnit = IntervalUnit.WEEK
        return this
    }    
