    public static func nextGivenSecondDate(date0: ?DateTime,  secondBase: Int64): DateTime {
        if (secondBase < 0 || secondBase > 59) {
            throw IllegalArgumentException("secondBase must be >=0 and <= 59")
        }

        let date = date0 ?? DateTime.now()
        let c = Calendars.getInstance(date.zone)
        c.setTime(date)

        if (secondBase == 0) {
            c.add(Calendars.MINUTE, 1)
            c.set(Calendars.SECOND, 0)
            c.set(Calendars.MILLISECOND, 0)

            return c.getTime()
        }

        var second: Int64 = c.get(Calendars.SECOND)

        var arItr: Int64 = second / secondBase

        var nextSecondOccurance: Int64 = secondBase * (arItr + 1)

        if (nextSecondOccurance < 60) {
            c.set(Calendars.SECOND, nextSecondOccurance)
            c.set(Calendars.MILLISECOND, 0)

            return c.getTime()
        } else {
            c.add(Calendars.MINUTE, 1)
            c.set(Calendars.SECOND, 0)
            c.set(Calendars.MILLISECOND, 0)

            return c.getTime()
        }
    }    