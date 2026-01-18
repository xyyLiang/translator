    public CalendarIntervalScheduleBuilder withInterval(int timeInterval, IntervalUnit unit) {
        if(unit == null)
            throw new IllegalArgumentException("TimeUnit must be specified.");
        validateInterval(timeInterval);
        this.interval = timeInterval;
        this.intervalUnit = unit;
        return this;
    }