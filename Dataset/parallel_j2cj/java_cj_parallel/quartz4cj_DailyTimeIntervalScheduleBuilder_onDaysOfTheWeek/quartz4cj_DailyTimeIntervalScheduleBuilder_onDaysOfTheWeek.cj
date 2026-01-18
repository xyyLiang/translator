    public func onDaysOfTheWeek(onDaysOfWeek: Set<Int64>): DailyTimeIntervalScheduleBuilder {
        if(onDaysOfWeek.size == 0) {
            throw IllegalArgumentException("Days of week must be an non-empty set.")
        }
        
        for (day in onDaysOfWeek) {
            if (!ALL_DAYS_OF_THE_WEEK.contains(day)) {
                throw IllegalArgumentException("Invalid value for day of week: " + day.toString())
            }
        }
                
        this.daysOfWeek = onDaysOfWeek
        return this
    }