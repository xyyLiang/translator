    public func getFireTimeAfter(afterTime0: ?DateTime): ?DateTime {
        if (complete) {
            return None
        }

        if ((timesTriggered > repeatCount) && (repeatCount != REPEAT_INDEFINITELY)) {
            return None
        }
        
        let afterTime = afterTime0 ?? DateTime.now()

        if (repeatCount == 0 && afterTime >= getStartTime()) {
            return None
        }

        let startMillis = getStartTime().getTime()
        let afterMillis = afterTime.getTime()
        let endMillis =  if( getEndTime() != None) { getEndTime().getOrThrow().getTime()   } else { Int64.MAX_VALUE }

        if (endMillis <= afterMillis) {
            return None
        }

        if (afterMillis < startMillis) {
            return DateTime.fromUnixTimeStampWithTimeZone(startMillis)
        }

        let numberOfTimesExecuted = ((afterMillis - startMillis) / repeatInterval) + 1
        if ((numberOfTimesExecuted > repeatCount) &&  (repeatCount != REPEAT_INDEFINITELY)) {
            return None
        }

        let time = DateTime.fromUnixTimeStampWithTimeZone(startMillis + (numberOfTimesExecuted * repeatInterval))

        if (endMillis <= time.getTime()) {
            return None
        }

        return time
    }
