    public func withIntervalInMonths(intervalInMonths: Int64): CalendarIntervalScheduleBuilder {
        validateInterval(intervalInMonths)
        this.interval = intervalInMonths
        this.intervalUnit = IntervalUnit.MONTH
        return this
    }    