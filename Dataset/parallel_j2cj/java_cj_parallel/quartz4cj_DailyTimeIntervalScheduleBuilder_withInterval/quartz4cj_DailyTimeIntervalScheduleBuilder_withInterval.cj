    public func withInterval(timeInterval: Int64, unit: IntervalUnit): DailyTimeIntervalScheduleBuilder {
        if (!(unit == IntervalUnit.SECOND || unit == IntervalUnit.MINUTE || unit == IntervalUnit.HOUR)) {
            throw IllegalArgumentException("Invalid repeat IntervalUnit (must be SECOND, MINUTE or HOUR).")
        }
        validateInterval(timeInterval)
        this.interval = timeInterval
        this.intervalUnit = unit
        return this
    }