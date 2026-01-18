    public static func nextGivenMinuteDate(date0: ?DateTime, minuteBase: Int64): DateTime {
        if (minuteBase < 0 || minuteBase > 59) {
            throw IllegalArgumentException("minuteBase must be >=0 and <= 59")
        }

        let date = date0 ?? DateTime.now()
        let c = Calendars.getInstance(date.zone)
        c.setTime(date)

        if (minuteBase == 0) {
            c.add(Calendars.HOUR_OF_DAY, 1)
            c.set(Calendars.MINUTE, 0)
            c.set(Calendars.SECOND, 0)
            c.set(Calendars.MILLISECOND, 0)

            return c.getTime()
        }

        var minute: Int64 = c.get(Calendars.MINUTE)

        var arItr: Int64 = minute / minuteBase

        var nextMinuteOccurance: Int64 = minuteBase * (arItr + 1)

        if (nextMinuteOccurance < 60) {
            c.set(Calendars.MINUTE, nextMinuteOccurance)
            c.set(Calendars.SECOND, 0)
            c.set(Calendars.MILLISECOND, 0)

            return c.getTime()
        } else {
            c.add(Calendars.HOUR_OF_DAY, 1)
            c.set(Calendars.MINUTE, 0)
            c.set(Calendars.SECOND, 0)
            c.set(Calendars.MILLISECOND, 0)

            return c.getTime()
        }
    }    