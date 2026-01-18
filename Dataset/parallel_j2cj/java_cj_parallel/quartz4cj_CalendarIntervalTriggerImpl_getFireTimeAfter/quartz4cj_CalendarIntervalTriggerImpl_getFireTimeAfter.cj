    protected func getFireTimeAfter(afterTime0: ?DateTime, ignoreEndTime: Bool): ?DateTime {
        if (complete) {
            return None
        }

        let afterTime1 = afterTime0 ?? DateTime.now(timeZone: getTimeZone())
        var afterTime = afterTime1.inTimeZone(getTimeZone())

        var startMillis: Int64 = getStartTime().getTime()
        var afterMillis: Int64 = afterTime.getTime() 
        var endMillis = Int64.MAX_VALUE
        if(getEndTime() != None) {      
            endMillis = getEndTime().getOrThrow().getTime()  
        }

        if (!ignoreEndTime && (endMillis <= afterMillis)) {
            return None
        }

        if (afterMillis < startMillis) {
            return DateTime.fromUnixTimeStampWithTimeZone(startMillis,timeZone: getTimeZone())
        }

        var secondsAfterStart: Int64 = 1 + (afterMillis - startMillis) / 1000
        var time: ?DateTime = None
        var repeatLong: Int64 = getRepeatInterval()

        var sTime = Calendars.getInstance(getTimeZone())
        sTime.setTime(getStartTime())
        
        if(getRepeatIntervalUnit() == IntervalUnit.SECOND) {
            var jumpCount: Int64 = secondsAfterStart / repeatLong
            if(secondsAfterStart % repeatLong != 0) {
                jumpCount++
            }
            sTime.add(Calendars.SECOND, getRepeatInterval() * jumpCount)
            time = sTime.getTime()
        } else if(getRepeatIntervalUnit() == IntervalUnit.MINUTE) {
            var jumpCount: Int64 = secondsAfterStart / (repeatLong * 60)
            if(secondsAfterStart % (repeatLong * 60) != 0) {
                jumpCount++
            }
            sTime.add(Calendars.MINUTE, getRepeatInterval() * jumpCount)
            time = sTime.getTime()
        }  else if(getRepeatIntervalUnit() == IntervalUnit.HOUR) {
            var jumpCount: Int64 = secondsAfterStart / (repeatLong * 60 * 60)
            if(secondsAfterStart % (repeatLong * 60 * 60) != 0) {
                jumpCount++
            }
            sTime.add(Calendars.HOUR_OF_DAY, getRepeatInterval() * jumpCount)
            time = sTime.getTime()
        } else { // intervals a day or greater ...

            var initialHourOfDay: Int64 = sTime.get(Calendars.HOUR_OF_DAY)
            
            if(getRepeatIntervalUnit() == IntervalUnit.DAY) {
                var jumpCount: Int64 = secondsAfterStart / (repeatLong * 24 * 60 * 60)
                // if we need to make a big jump, jump most of the way there, 
                // but not all the way because in some cases we may over-shoot or under-shoot
                if(jumpCount > 20) {
                    if(jumpCount < 50) {
                        jumpCount = Int64(Float64(jumpCount) * 0.80)
                    } else if(jumpCount < 500) {
                        jumpCount = Int64(Float64(jumpCount) * 0.90)
                    } else {
                        jumpCount = Int64(Float64(jumpCount) * 0.95)
                    }
                    sTime.add(Calendars.DAY_OF_YEAR, Int64(getRepeatInterval() * jumpCount))
                }
                // now baby-step the rest of the way there...
                while(sTime.getTime().getTime() < afterMillis + 1000 && // quartz 原有代码这里有 bug, 触发时间应该是afterTime之后的时间，应该往后推1秒再比较, 已修复
                        (sTime.get(Calendars.YEAR) < TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT)) {            
                    sTime.add(Calendars.DAY_OF_YEAR, getRepeatInterval())
                }
                while(daylightSavingHourShiftOccurredAndAdvanceNeeded(sTime, initialHourOfDay, afterTime) &&
                        (sTime.get(Calendars.YEAR) < TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT)) {
                    sTime.add(Calendars.DAY_OF_YEAR, getRepeatInterval())
                }

                time = sTime.getTime()
            } else if(getRepeatIntervalUnit() == IntervalUnit.WEEK) {
                var jumpCount: Int64 = secondsAfterStart / (repeatLong * 7 * 24 * 60 * 60)
                // if we need to make a big jump, jump most of the way there, 
                // but not all the way because in some cases we may over-shoot or under-shoot
                if(jumpCount > 20) {
                    if(jumpCount < 50) {
                        jumpCount = Int64(Float64(jumpCount) * 0.80)
                    } else if(jumpCount < 500) {
                        jumpCount = Int64(Float64(jumpCount) * 0.90)
                    } else {
                        jumpCount = Int64(Float64(jumpCount) * 0.95)
                    }
                    sTime.add(Calendars.WEEK_OF_YEAR, Int64 (getRepeatInterval() * jumpCount))
                }
                
                while(sTime.getTime().getTime() < afterMillis + 1000 &&  // quartz 原有代码这里有 bug, 触发时间应该是afterTime之后的时间， 应该往后推1秒再比较, 已修复
                        (sTime.get(Calendars.YEAR) < TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT)) {            
                    sTime.add(Calendars.WEEK_OF_YEAR, getRepeatInterval())
                }
                while(daylightSavingHourShiftOccurredAndAdvanceNeeded(sTime, initialHourOfDay, afterTime) &&
                        (sTime.get(Calendars.YEAR) < TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT)) {
                    sTime.add(Calendars.WEEK_OF_YEAR, getRepeatInterval())
                }
                time = sTime.getTime()
            } else if(getRepeatIntervalUnit() == IntervalUnit.MONTH) {    
                // because of the large variation in size of months, and 
                // because months are already large blocks of time, we will
                // just advance via brute-force iteration.
                
                while(sTime.getTime().getTime() < afterMillis + 1000 &&  // quartz 原有代码这里有 bug, 触发时间应该是afterTime之后的时间，应该往后推1秒再比较, 已修复
                        (sTime.get(Calendars.YEAR) < TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT)) {            
                    sTime.add(Calendars.MONTH, getRepeatInterval())
                }
                while(daylightSavingHourShiftOccurredAndAdvanceNeeded(sTime, initialHourOfDay, afterTime) &&
                        (sTime.get(Calendars.YEAR) < TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT)) {
                    sTime.add(Calendars.MONTH, getRepeatInterval())
                }
                time = sTime.getTime()
            } else if(getRepeatIntervalUnit() == IntervalUnit.YEAR) {
    
                while(sTime.getTime().getTime() < afterMillis + 1000 &&  // quartz 原有代码这里有 bug, 触发时间应该是afterTime之后的时间，应该往后推1秒再比较, 已修复
                        (sTime.get(Calendars.YEAR) < TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT)) {            
                    sTime.add(Calendars.YEAR, getRepeatInterval())
                }
                while(daylightSavingHourShiftOccurredAndAdvanceNeeded(sTime, initialHourOfDay, afterTime) &&
                        (sTime.get(Calendars.YEAR) < TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT)) {
                    sTime.add(Calendars.YEAR, getRepeatInterval())
                }
                time = sTime.getTime()
            }
        } // case of interval of a day or greater
        
        if (!ignoreEndTime && (endMillis <= time.getOrThrow().getTime())) {
            return None
        }

        return time
    }   