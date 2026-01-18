    public func startingDailyAt(timeOfDay: ?TimeOfDay): DailyTimeIntervalScheduleBuilder {
        if(!timeOfDay.isPresent()) {
            throw IllegalArgumentException("Start time of day cannot be null!")
        }
        
        this.startTimeOfDay = timeOfDay
        return this
    }  