    public func willFireOn(testCal0: Calendars, dayOnly: Bool): Bool {
        var testCal = testCal0.clone()
        testCal.set(Calendars.MILLISECOND, 0) // don't compare millis.
        
        if(dayOnly) {
            testCal.set(Calendars.HOUR_OF_DAY, 0) 
            testCal.set(Calendars.MINUTE, 0) 
            testCal.set(Calendars.SECOND, 0) 
        }
        
        var testTime = testCal.getTime()
        
        var dateTime = testTime.addSeconds(-1) 
        var fta = getFireTimeAfter(dateTime)
        
        if(fta == None) {
            return false
        }

        var p = Calendars.getInstance(testCal.getTimeZone())
        p.setTime(fta.getOrThrow())
        
        var year: Int64 = p.get(Calendars.YEAR)
        var month: Int64 = p.get(Calendars.MONTH)
        var day: Int64 = p.get(Calendars.DAY_OF_MONTH)
        
        if(dayOnly) {
            return (year == testCal.get(Calendars.YEAR) && month == testCal.get(Calendars.MONTH) && day == testCal.get(Calendars.DAY_OF_MONTH))
        }

        while(fta.getOrThrow() < testTime) {
            fta = getFireTimeAfter(fta)
        }

        return fta == testTime
    }    