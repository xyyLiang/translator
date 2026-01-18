    public func setDaysExcluded(days: ArrayList<DateTime> ): Unit  {
        if (days.size == 0) {
            excludeDays = ArrayList<DateTime>();
        } else {
            excludeDays = days;
        }

        for( i in 0..excludeDays.size ) {
            excludeDays[i] = excludeDays[i].inTimeZone(getActualTimeZone())
        }

        dataSorted = false;
    }