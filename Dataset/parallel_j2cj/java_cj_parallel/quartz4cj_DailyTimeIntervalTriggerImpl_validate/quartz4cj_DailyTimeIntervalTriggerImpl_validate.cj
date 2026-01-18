    public override func validate(): Unit {
        super.validate()
        
        if (!((repeatIntervalUnit == IntervalUnit.SECOND) || 
                repeatIntervalUnit == IntervalUnit.MINUTE ||
                repeatIntervalUnit == IntervalUnit.HOUR)) {
            throw SchedulerException("Invalid repeat IntervalUnit (must be SECOND, MINUTE or HOUR).")
        }
        if (repeatInterval < 1) {
            throw SchedulerException("Repeat Interval cannot be zero.")
        }
        
        // Ensure interval does not exceed 24 hours
        var secondsInHour = 24 * 60 * 60
        if (repeatIntervalUnit == IntervalUnit.SECOND && repeatInterval > secondsInHour) {
            throw SchedulerException("repeatInterval can not exceed 24 hours (" + secondsInHour.toString() + " seconds). Given " + repeatInterval.toString())
        }
        if (repeatIntervalUnit == IntervalUnit.MINUTE && repeatInterval > secondsInHour / 60) {
            throw SchedulerException("repeatInterval can not exceed 24 hours (" + (secondsInHour / 60).toString() + " minutes). Given " + repeatInterval.toString())
        }
        if (repeatIntervalUnit == IntervalUnit.HOUR && repeatInterval > 24 ) {
            throw SchedulerException("repeatInterval can not exceed 24 hours. Given " + repeatInterval.toString() + " hours.")
        }        
        
        // Ensure timeOfDay is in order.
        // NOTE: We allow startTimeOfDay to be set equal to endTimeOfDay so the repeatCount can be set to 1.
        if ( endTimeOfDay.isPresent() && getStartTimeOfDay() > endTimeOfDay.getOrThrow() ) {
            throw SchedulerException("StartTimeOfDay " + startTimeOfDay.toString() + " should not come after endTimeOfDay " + endTimeOfDay.toString())
        }
    }     