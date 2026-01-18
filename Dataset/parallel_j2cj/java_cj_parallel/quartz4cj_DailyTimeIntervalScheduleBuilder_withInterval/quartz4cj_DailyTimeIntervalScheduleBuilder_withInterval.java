    public DailyTimeIntervalScheduleBuilder withInterval(int timeInterval, IntervalUnit unit) {
        if (unit == null || !(unit.equals(IntervalUnit.SECOND) || 
                unit.equals(IntervalUnit.MINUTE) ||unit.equals(IntervalUnit.HOUR)))
            throw new IllegalArgumentException("Invalid repeat IntervalUnit (must be SECOND, MINUTE or HOUR).");
        validateInterval(timeInterval);
        this.interval = timeInterval;
        this.intervalUnit = unit;
        return this;
    }