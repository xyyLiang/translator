    public func onDaysOfTheWeek(onDaysOfWeek: Array<Int64>): DailyTimeIntervalScheduleBuilder {
        let daysAsSet = HashSet<Int64>();
        daysAsSet.putAll(onDaysOfWeek);
        return onDaysOfTheWeek(daysAsSet);
    }