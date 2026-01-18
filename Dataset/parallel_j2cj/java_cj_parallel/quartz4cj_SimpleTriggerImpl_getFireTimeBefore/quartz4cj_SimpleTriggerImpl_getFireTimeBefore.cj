    public func getFireTimeBefore(end: DateTime): ?DateTime {
        if (end.getTime() < getStartTime().getTime()) {
            return None
        }

        let numFires = computeNumTimesFiredBetween(getStartTime(), end)
        
        return DateTime.fromUnixTimeStampWithTimeZone(getStartTime().getTime() + (numFires * repeatInterval))
    }  