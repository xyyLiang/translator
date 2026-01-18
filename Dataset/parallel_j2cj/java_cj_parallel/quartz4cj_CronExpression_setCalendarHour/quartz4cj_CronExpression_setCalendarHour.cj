    private func setCalendarHour(cal: Calendars, hour: Int64): Unit {
        cal.set(Calendars.HOUR_OF_DAY, hour)

        if (cal.get(Calendars.HOUR_OF_DAY) != hour && hour < 24) {
            cal.set(Calendars.HOUR_OF_DAY, hour + 1)
        }
    }