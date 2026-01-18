    public override func getFinalFireTime(): ?DateTime {

        if (complete ) {
            return None
        }

        var eTime = getEndTime() ?? return None 

        // We have an endTime, we still need to check to see if there is a endTimeOfDay if that's applicable.

        if ( let Some(et) <- endTimeOfDay ) {
            var endTimeOfDayDate = et.getTimeOfDayForDate(eTime)
            if (eTime > endTimeOfDayDate) { // quartz 原有代码这里有 bug, 应该是 >, 已修复
                eTime = endTimeOfDayDate
            }
        }

        // quartz 原有代码这里有 bug, 代码没写完， 直接把 endTime 当成 finalFireTime, 不做修复

        return eTime
    } 