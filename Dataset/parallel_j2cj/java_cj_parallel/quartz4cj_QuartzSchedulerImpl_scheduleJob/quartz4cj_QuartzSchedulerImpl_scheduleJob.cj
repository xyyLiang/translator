    public func scheduleJob( jobDetail: JobDetail,  trigger0: Trigger) : DateTime {

        validateJobKey(jobDetail.getKey())
        validateTriggerKey(trigger0.getKey())

        validateState();

        let trig = (trigger0 as OperableTrigger).getOrThrow()

        if (trig.getJobKey() == JobKey.EMPTY_KEY) {
            trig.setJobKey(jobDetail.getKey());
        } else if ( trig.getJobKey() != jobDetail.getKey() ) {
            throw SchedulerException( "Trigger does not reference given job!");
        }

        trig.validate();

        var cal : ?Calendar = None;
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
                resources.getJobStore().storeJobAndTrigger(jobDetail, trig);
                notifySchedulerThread(trig.getNextFireTime().getOrThrow().getTime());
                notifySchedulerListenersJobAdded(jobDetail);
                notifySchedulerListenersScheduled(trig);
                return t;
        }
    }