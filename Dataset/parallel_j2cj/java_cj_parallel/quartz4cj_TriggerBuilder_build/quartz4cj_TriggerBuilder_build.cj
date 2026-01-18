    public func build(): T {

        scheduleBuilder = scheduleBuilder ??  SimpleScheduleBuilder.simpleSchedule()

        let trig = scheduleBuilder.getOrThrow().build()

        key = if( key == TriggerKey.EMPTY_KEY ) { TriggerKey(TriggerKey.createUniqueName()) } else { key }
        trig.setKey(key)

        trig.setCalendarName(calendarName)
        trig.setDescription(description)
        trig.setStartTime(startTime)
        trig.setEndTime(endTime)  // 可能为空

        if( jobKey != JobKey.EMPTY_KEY ) {
            trig.setJobKey(jobKey)
        }
        
        trig.setPriority(priority)

        if(!jobDataMap.isEmpty()){
            trig.setJobDataMap(jobDataMap)
        }

        return ( trig as T ).getOrThrow()
    }