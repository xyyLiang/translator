    public func isDayExcluded(day0: DateTime) : Bool  {

        let day = day0.inTimeZone(getActualTimeZone())

         // Check baseCalendar first
        if (!super.isTimeIncluded(day.getTime())) {
            return true;
        }

        let dmonth = day.monthValue
        let dday = day.dayOfMonth

        if (!dataSorted) {
            excludeDays.sortBy(compareDateTimeForAnnualCalendar, stable: true)
            dataSorted = true;
        }

        for( cl in excludeDays ) {

            // remember, the list is sorted
            if (dmonth < cl.monthValue) {
                return false;
            }

            if (dday != cl.dayOfMonth) {
                continue;
            }

            if (dmonth != cl.monthValue) {
                continue;
            }

            return true;
        }

        return false;
    }