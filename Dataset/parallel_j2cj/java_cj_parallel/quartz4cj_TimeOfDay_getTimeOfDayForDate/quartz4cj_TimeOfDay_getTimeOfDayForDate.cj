    public func getTimeOfDayForDate(dateTime: DateTime): DateTime {
      return DateTime.of(
            year: dateTime.year,
            month: dateTime.month,
            dayOfMonth: dateTime.dayOfMonth,
            hour: hour,
            minute: minute,
            second: second,
            nanosecond: 0,
            timeZone: dateTime.zone
        )
    } 