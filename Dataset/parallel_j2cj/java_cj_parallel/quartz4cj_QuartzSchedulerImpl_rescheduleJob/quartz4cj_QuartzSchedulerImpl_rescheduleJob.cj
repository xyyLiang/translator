    public func rescheduleJob( triggerKey: TriggerKey,    newTrigger: Trigger) : ?DateTime {

        validateTriggerKey(newTrigger.getKey())

        validateState();

        let trig = (newTrigger as OperableTrigger).getOrThrow()

        let oldTriggerOpt = getTrigger(triggerKey);
        if ( let Some(oldTrigger) <- oldTriggerOpt) {
            trig.setJobKey(oldTrigger.getJobKey());
        } else {
            return None;
        }

        trig.validate();

        var cal : ?Calendar = None;

        if (trig.getCalendarName() != "") {
            cal = resources.getJobStore().retrieveCalendar( trig.getCalendarName());
            if(!cal.isPresent()) {
                throw SchedulerException(  "Calendar not found: ${trig.getCalendarName()} for trigger ${trig.getKey()}");
            }
        }

        let ftOpt = trig.computeFirstFireTime(cal);
        let ft = ftOpt ?? throw SchedulerException( "Based on configured schedule, the given trigger will never fire.");

        if (resources.getJobStore().replaceTrigger(triggerKey, trig)) {
            notifySchedulerThread(newTrigger.getNextFireTime().getOrThrow().getTime());
            notifySchedulerListenersUnscheduled(triggerKey);
            notifySchedulerListenersScheduled(newTrigger);
        } else {
            return None;
        }

        return ft;
    }