    public func withIntervalInYears(intervalInYears: Int64): CalendarIntervalScheduleBuilder {
        validateInterval(intervalInYears)
        this.interval = intervalInYears
        this.intervalUnit = IntervalUnit.YEAR
        return this
    }    