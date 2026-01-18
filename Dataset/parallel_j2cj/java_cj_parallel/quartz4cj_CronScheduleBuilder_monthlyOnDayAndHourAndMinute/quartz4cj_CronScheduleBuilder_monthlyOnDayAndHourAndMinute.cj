    public static func monthlyOnDayAndHourAndMinute(dayOfMonth: Int64, hour: Int64, minute: Int64): CronScheduleBuilder {
        DateBuilder.validateDayOfMonth(dayOfMonth)
        DateBuilder.validateHour(hour)
        DateBuilder.validateMinute(minute)

        let cronExpression = "0 ${minute} ${hour} ${dayOfMonth} * ?"
        return cronScheduleNoParseException(cronExpression)
    }   