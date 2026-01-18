    public func resumeJobs( matcher: GroupMatcher<JobKey>) : Collection<String> {
        
        synchronized (lock) {

            let resumedGroups = HashSet<String>();
            let keys = getJobKeys(matcher);
            let op = matcher.getCompareWithOperator()

            for (pausedJobGroup in pausedJobGroups) {
                if(op.evaluate(pausedJobGroup, matcher.getCompareToValue())) {
                    resumedGroups.put(pausedJobGroup);
                }
            }

            for (resumedGroup in resumedGroups) {
                pausedJobGroups.remove(resumedGroup);
            }

            for (key in keys) {
                let triggersOfJob = getTriggersForJob(key);
                for (trigger in triggersOfJob) {
                    resumeTrigger(trigger.getKey());
                }
            }

            return resumedGroups;
        }
        
    }