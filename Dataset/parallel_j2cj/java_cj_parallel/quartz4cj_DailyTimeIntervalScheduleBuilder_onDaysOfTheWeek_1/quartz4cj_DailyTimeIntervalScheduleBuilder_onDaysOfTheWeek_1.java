    public DailyTimeIntervalScheduleBuilder onDaysOfTheWeek(Integer ... onDaysOfWeek) {
        Set<Integer> daysAsSet = new HashSet<Integer>(12);
        Collections.addAll(daysAsSet, onDaysOfWeek);
        return onDaysOfTheWeek(daysAsSet);
    }