    public func getFinalFireTime(): ?DateTime {
        if (repeatCount == 0) {
            return startTime
        }

        if (repeatCount == REPEAT_INDEFINITELY) {
            if(getEndTime() == None) {
                return None
            }
            return getFireTimeBefore(getEndTime().getOrThrow().addNanoseconds(-1000000))  // quartz 原有代码这里有 bug, endTime不能是最后一次触发时间, 已修复
        }

        let lastTrigger = startTime.getTime() + (repeatCount * repeatInterval)

        if ((getEndTime() == None) || (lastTrigger < getEndTime().getOrThrow().getTime())) { 
            return DateTime.fromUnixTimeStampWithTimeZone(lastTrigger)
        } else {
            return getFireTimeBefore(getEndTime().getOrThrow().addNanoseconds(-1000000))  // quartz 原有代码这里有 bug, endTime不能是最后一次触发时间, 已修复
        }
    } 