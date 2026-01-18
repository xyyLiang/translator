    public func pauseJobs( matcher: GroupMatcher<JobKey>)  : Collection<String> {
        
        synchronized (lock) {

            let pausedGroups = ArrayList<String>();

            let op = matcher.getCompareWithOperator();
            match (op) {
                case EQUALS =>
                    if (pausedJobGroups.put(matcher.getCompareToValue())) {
                        pausedGroups.append(matcher.getCompareToValue());
                    } 
                case _ =>
                    for (group in jobsByGroup.keys()) {
                        if(op.evaluate(group, matcher.getCompareToValue())) {
                            if (pausedJobGroups.put(group)) {
                                pausedGroups.append(group);
                            }
                        }
                    }
            }

            for (groupName in pausedGroups) {
                for (jobKey in getJobKeys(GroupMatcher<JobKey>.groupEquals(groupName))) {
                    let triggersOfJob = getTriggersForJob(jobKey);
                    for (trigger in triggersOfJob) {
                        pauseTrigger(trigger.getKey());
                    }
                }
            }

            return pausedGroups;
        }

    }