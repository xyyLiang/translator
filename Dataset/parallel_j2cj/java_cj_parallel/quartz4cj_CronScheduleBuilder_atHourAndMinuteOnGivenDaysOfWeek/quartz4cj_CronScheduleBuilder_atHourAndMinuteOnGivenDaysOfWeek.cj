    public static func atHourAndMinuteOnGivenDaysOfWeek(hour: Int64, minute: Int64, daysOfWeek: Array<Int64>): CronScheduleBuilder {
        if (daysOfWeek.size == 0) {
            throw IllegalArgumentException("You must specify at least one day of week.")
        }
        for (dayOfWeek in daysOfWeek) {
            DateBuilder.validateDayOfWeek(dayOfWeek)
        }
        DateBuilder.validateHour(hour)
        DateBuilder.validateMinute(minute)

        var cronExpression = "0 ${minute} ${hour} ? * ${daysOfWeek[0]}"

        for(i in 1..daysOfWeek.size) {
            cronExpression = cronExpression + "," + daysOfWeek[i].toString()
        }

        return cronScheduleNoParseException(cronExpression)
    }   