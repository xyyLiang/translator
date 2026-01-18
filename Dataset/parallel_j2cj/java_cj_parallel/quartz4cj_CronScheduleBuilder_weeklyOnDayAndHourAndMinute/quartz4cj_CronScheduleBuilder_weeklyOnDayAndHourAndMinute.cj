    public static func weeklyOnDayAndHourAndMinute(dayOfWeek: Int64, hour: Int64, minute: Int64): CronScheduleBuilder {
        DateBuilder.validateDayOfWeek(dayOfWeek)
        DateBuilder.validateHour(hour)
        DateBuilder.validateMinute(minute)

        let cronExpression = "0 ${minute} ${hour} ? * ${dayOfWeek}"
        return cronScheduleNoParseException(cronExpression)
    }  