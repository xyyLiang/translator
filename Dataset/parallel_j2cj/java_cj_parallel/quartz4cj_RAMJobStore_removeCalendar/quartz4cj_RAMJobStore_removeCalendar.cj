    public func removeCalendar(calName: String) : Bool  {
        var numRefs = 0;

        synchronized (lock) {
            for (trigger in triggersByKey.values()) {
                let trigg = trigger.trigger;
                if (trigg.getCalendarName() != ""  && trigg.getCalendarName() == calName) { 
                    numRefs++;
                }
            }

            if (numRefs > 0) {
                throw JobPersistenceException( "Calender cannot be removed if it referenced by a Trigger!");
            }

            return calendarsByName.remove(calName).isPresent()
        }
    }