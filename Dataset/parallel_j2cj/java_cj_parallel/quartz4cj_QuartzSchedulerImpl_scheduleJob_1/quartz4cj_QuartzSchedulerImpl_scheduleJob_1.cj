    public func scheduleJob(trig0 : Trigger): DateTime {

        validateTriggerKey(trig0.getKey())
        validateJobKey(trig0.getJobKey())

        validateState();
        
        let trig = (trig0 as OperableTrigger).getOrThrow()
        
        trig.validate();

        var cal : ?Calendar = None
        if (trig.getCalendarName() != "") {
            cal = resources.getJobStore().retrieveCalendar(trig.getCalendarName());
            if(!cal.isPresent()) {
                throw SchedulerException(  "Calendar not found: ${trig.getCalendarName()}");
            }
        }

        let ft = trig.computeFirstFireTime(cal);
        match( ft ) {
            case None => 
                throw SchedulerException(   "Based on configured schedule, the given trigger '${trig.getKey()}' will never fire.");
            case Some(t) =>
                resources.getJobStore().storeTrigger(trig, false);
                notifySchedulerThread(trig.getNextFireTime().getOrThrow().getTime());
                notifySchedulerListenersScheduled(trig);
                return t;
        }
    }