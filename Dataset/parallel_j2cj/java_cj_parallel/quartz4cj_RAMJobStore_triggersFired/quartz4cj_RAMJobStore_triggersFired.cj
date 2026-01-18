    public func triggersFired( firedTriggers: Collection<OperableTrigger>) : ArrayList<TriggerFiredResult> {

        synchronized (lock) {
            let results = ArrayList<TriggerFiredResult>();

            for (trigger in firedTriggers) {
                let twOpt = triggersByKey.get(trigger.getKey());
                let tw = twOpt ?? continue;

                // was the trigger completed, paused, blocked, etc. since being acquired?
                if (tw.state != TriggerWrapper.STATE_ACQUIRED) {
                    continue;
                }

                var calOpt : ?Calendar = None;
                if (tw.trigger.getCalendarName() != "") {
                    calOpt = retrieveCalendar(tw.trigger.getCalendarName());
                    if( !calOpt.isPresent()) {
                        continue;
                    }
                }

                let prevFireTimeOpt = trigger.getPreviousFireTime();
                // in case trigger was replaced between acquiring and firing
                timeTriggers.remove(tw);
                // call triggered on our copy, and the scheduler's copy

                tw.trigger.triggered(calOpt); 

                trigger.triggered(calOpt); 

                tw.state = TriggerWrapper.STATE_WAITING;

                let jd = retrieveJob(tw.jobKey).getOrThrow()

                let bndle = TriggerFiredBundle(
                        jd,
                        trigger, 
                        calOpt,
                        false, 
                        DateTime.now(), 
                        trigger.getPreviousFireTime().getOrThrow(), // 刚triggered过，一定有值
                        prevFireTimeOpt,
                        trigger.getNextFireTime());

                let job = bndle.getJobDetail();

                if (job.isConcurrentExectionDisallowed()) {
                    let trigs = getTriggerWrappersForJob(job.getKey());
                    for (ttw in trigs) {
                        if (ttw.state == TriggerWrapper.STATE_WAITING) {
                            ttw.state = TriggerWrapper.STATE_BLOCKED;
                        }
                        if (ttw.state == TriggerWrapper.STATE_PAUSED) {
                            ttw.state = TriggerWrapper.STATE_PAUSED_BLOCKED;
                        }
                        timeTriggers.remove(ttw);
                    }
                    blockedJobs.put(job.getKey());
                } else if (tw.trigger.getNextFireTime().isPresent()) {
                    timeTriggers.put(tw);
                }

                results.append(TriggerFiredResult(trigger,bndle));
            }

            return results;
        }


    }