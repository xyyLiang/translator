    public DailyTimeIntervalScheduleBuilder startingDailyAt(TimeOfDay timeOfDay) {
        if(timeOfDay == null)
            throw new IllegalArgumentException("Start time of day cannot be null!");
        
        this.startTimeOfDay = timeOfDay;
        return this;
    }