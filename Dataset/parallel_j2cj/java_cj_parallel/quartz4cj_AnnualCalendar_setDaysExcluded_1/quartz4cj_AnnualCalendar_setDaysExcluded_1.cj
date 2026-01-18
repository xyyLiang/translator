    public func setDayExcluded(day0: DateTime, exclude: Bool ): Unit {

        let day = day0.inTimeZone(getActualTimeZone())

        if (exclude) {
            if (isDayExcluded(day)) {
                return;
            }

            excludeDays.append(day);
            dataSorted = false;
        } else {
            if (!isDayExcluded(day)) {
                return;
            }

            removeExcludedDay(day, true);
        }
    }