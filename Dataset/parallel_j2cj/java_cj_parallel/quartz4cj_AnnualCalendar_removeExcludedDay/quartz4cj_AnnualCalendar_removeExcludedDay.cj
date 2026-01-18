    private func removeExcludedDay(day0: DateTime,  isChecked: Bool ) : Unit{
        var day = day0.inTimeZone(getActualTimeZone())
        if (!isChecked && !isDayExcluded(day)) {
            return;
        }
        
        // Fast way, see if exact day object was already in list
        if (this.excludeDays.removeByValue(day)){
            return;
        }
        
        let dmonth = day.monthValue
        let dday = day.dayOfMonth
        
        // Since there is no guarantee that the given day is in the arraylist with the exact same year
        // search for the object based on month and day of month in the list and remove it
        for( cl in excludeDays ) {

            if (dmonth != cl.monthValue) {
                continue;
            }

            if (dday != cl.dayOfMonth) {
                continue;
            }

            day = cl;
            break;
        }
        
        this.excludeDays.removeByValue(day);
    }