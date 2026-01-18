    public func withInterval(timeInterval: Int64, unit: IntervalUnit): CalendarIntervalScheduleBuilder {
        validateInterval(timeInterval)
        this.interval = timeInterval
        this.intervalUnit = unit
        return this
    }
