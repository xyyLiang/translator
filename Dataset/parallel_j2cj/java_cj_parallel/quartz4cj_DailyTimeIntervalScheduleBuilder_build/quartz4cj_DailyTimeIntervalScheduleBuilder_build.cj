    public func build(): MutableTrigger {
        let t = DailyTimeIntervalTriggerImpl()
        t.setRepeatInterval(interval)
        t.setRepeatIntervalUnit(intervalUnit)
        t.setMisfireInstruction(misfireInstruction)
        t.setRepeatCount(repeatCount)
        
        if(!daysOfWeek.isEmpty()) {
            t.setDaysOfWeek(daysOfWeek)
        } else{
            t.setDaysOfWeek(ALL_DAYS_OF_THE_WEEK)
        }

        if( let Some(v) <- startTimeOfDay ) {
            t.setStartTimeOfDay(v)
        } else {
            t.setStartTimeOfDay(TimeOfDay.hourAndMinuteOfDay(0, 0))
        }

        if(let Some(v) <- endTimeOfDay) {
            t.setEndTimeOfDay(v)
        } else {
            t.setEndTimeOfDay(TimeOfDay.hourMinuteAndSecondOfDay(23, 59, 59))
        }

        return t
    }    