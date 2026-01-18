    public override func getFireTimeAfter(afterTime0: ?DateTime): ?DateTime {

        if( !cronEx.isPresent() ) {
            return None 
        }

        let afterTime1 = afterTime0 ?? DateTime.now(timeZone: getTimeZone())
        var afterTime = afterTime1.inTimeZone(getTimeZone())

        if (getStartTime() > afterTime) { 
            afterTime = getStartTime().addSeconds(-1)
        }

        if (getEndTime() != None && (afterTime >= getEndTime().getOrThrow())) {
            return None
        }
        
        var pot = getTimeAfter(afterTime)
        if (getEndTime() != None && pot != None && pot.getOrThrow() >= getEndTime().getOrThrow()) { // quartz 原有代码这里有 bug, 不是 >, 应该是 >= 触发时间不能超过结束时间, 已修复
            return None
        }

        return pot
    } 