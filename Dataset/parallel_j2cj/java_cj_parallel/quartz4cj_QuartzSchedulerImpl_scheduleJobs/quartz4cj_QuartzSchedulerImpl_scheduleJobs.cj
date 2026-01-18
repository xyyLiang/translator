    public func scheduleJobs(triggersAndJobs0 : Map<JobDetail, Set<Trigger>> ,  replace: Bool )  :Unit  {

        for( (jd,set) in triggersAndJobs0 ) {
            validateJobKey(jd.getKey())
            for( t in set ) {
                validateTriggerKey(t.getKey())
            }
        }

        validateState();

        let triggersAndJobs = toOperableTriggers(triggersAndJobs0)

        // make sure all triggers refer to their associated job
        for( (job,triggers) in triggersAndJobs ) { 

            if(triggers.isEmpty() ) { // this is possible because the job may be durable, and not yet be having triggers
                continue;
            }

            for( opt in triggers) {

                opt.setJobKey(job.getKey());
                opt.validate();

                var cal : ?Calendar = None
                if (opt.getCalendarName() != "") {
                    cal = resources.getJobStore().retrieveCalendar(opt.getCalendarName());
                    if(!cal.isPresent()) {
                        throw SchedulerException(  "Calendar not found: ${opt.getCalendarName()} for trigger ${opt.getKey()}");
                    }
                }

                let ft = opt.computeFirstFireTime(cal);
                if (!ft.isPresent()) {
                    throw SchedulerException(  "Based on configured schedule, the given trigger will never fire.");
                }                
            }
        }

        resources.getJobStore().storeJobsAndTriggers(triggersAndJobs, replace);
        notifySchedulerThread(0);
        for ( (job,triggers) in triggersAndJobs) {
          notifySchedulerListenersJobAdded(job);
          for ( trigger in triggers) {
            notifySchedulerListenersScheduled(trigger);
          }
        }
    }