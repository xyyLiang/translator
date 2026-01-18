    public func acquireNextTriggers(noLaterThan: Int64, maxCount: Int64, timeWindow: Int64) : ArrayList<OperableTrigger>{

        synchronized (lock) {
            let result = ArrayList<OperableTrigger>();
            let acquiredJobKeysForNoConcurrentExec = HashSet<JobKey>();
            let excludedTriggers = HashSet<TriggerWrapper>();
            var batchEnd = noLaterThan;
            
            // return empty list if store has no triggers.
            if (timeTriggers.size == 0) {
                return result;
            }
            
            while (true) {

                let twOpt = timeTriggers.first()
                let tw = twOpt ?? break;
                timeTriggers.remove(tw);

                if (!tw.trigger.getNextFireTime().isPresent() ) {
                    continue;
                }

                if (applyMisfire(tw)) {
                    if (tw.trigger.getNextFireTime().isPresent()) {
                        timeTriggers.put(tw);
                    }
                    continue;
                }

                let nft = tw.trigger.getNextFireTime() ?? continue;

                if (nft.getTime() > batchEnd) {
                    timeTriggers.put(tw);
                    break;
                }
                
                // If trigger's job is set as @DisallowConcurrentExecution, and it has already been added to result, then
                // put it back into the timeTriggers set and continue to search for next trigger.
                let jobKey = tw.trigger.getJobKey();
                let job = jobsByKey.get(jobKey).getOrThrow().jobDetail;
                if (job.isConcurrentExectionDisallowed()) {
                    if (acquiredJobKeysForNoConcurrentExec.contains(jobKey)) {
                        excludedTriggers.put(tw);
                        continue; // go to next trigger in store.
                    } else {
                        acquiredJobKeysForNoConcurrentExec.put(jobKey);
                    }
                }

                tw.state = TriggerWrapper.STATE_ACQUIRED;
                tw.trigger.setFireInstanceId(getFiredTriggerRecordId());
                let trig = tw.trigger.clone();
                if (result.isEmpty()) {
                    let now = DateTime.now()
                    let max = if( nft > now ) { nft } else { now }
                    batchEnd = max.getTime() + timeWindow;
                }
                result.append(trig);
                if (result.size == maxCount) {
                    break;
                }
            }

            // If we did excluded triggers to prevent ACQUIRE state due to DisallowConcurrentExecution, we need to add them back to store.
            if (excludedTriggers.size > 0) {
                timeTriggers.putAll(excludedTriggers);
            }

            return result;
        }
    }