    public func getFinalFireTime(): ?DateTime {
        if (complete || getEndTime() == None) {
            return None
        }

        // back up a second from end time
        var fTime: ?DateTime = getEndTime().getOrThrow().addSeconds(-1)
        // find the next fire time after that
        fTime = getFireTimeAfter(fTime.getOrThrow(), true)
        
        if(fTime == None) { // quartz 原有代码这里有 bug, endTime不能是最后一次触发时间, 应再往前推一个时间单位, 已修复
            return None
        }
        
        // otherwise we have to back up one interval from the fire time after the end time
        var lTime: Calendars = Calendars.getInstance(getTimeZone())
        lTime.setTime(fTime.getOrThrow())
        
        if(getRepeatIntervalUnit() == IntervalUnit.SECOND) {
            lTime.add(Calendars.SECOND, -1 * getRepeatInterval())
        }
        else if(getRepeatIntervalUnit() == IntervalUnit.MINUTE) {
            lTime.add(Calendars.MINUTE, -1 * getRepeatInterval())
        }
        else if(getRepeatIntervalUnit() == IntervalUnit.HOUR) {
            lTime.add(Calendars.HOUR_OF_DAY, -1 * getRepeatInterval())
        }
        else if(getRepeatIntervalUnit() == IntervalUnit.DAY) {
            lTime.add(Calendars.DAY_OF_YEAR, -1 * getRepeatInterval())
        }
        else if(getRepeatIntervalUnit() == IntervalUnit.WEEK) {
            lTime.add(Calendars.WEEK_OF_YEAR, -1 * getRepeatInterval())
        }
        else if(getRepeatIntervalUnit() == IntervalUnit.MONTH) {
            lTime.add(Calendars.MONTH, -1 * getRepeatInterval())
        }
        else if(getRepeatIntervalUnit() == IntervalUnit.YEAR) {
            lTime.add(Calendars.YEAR, -1 * getRepeatInterval())
        }

        return lTime.getTime()
    }    