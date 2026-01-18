    public func resumeTriggers( matcher: GroupMatcher<TriggerKey>) : Collection<String> {
        
        synchronized (lock) {

            let groups = HashSet<String>();

            let keys = getTriggerKeys(matcher);

            for (triggerKey in keys) {
                groups.put(triggerKey.getGroup());
                let twOpt = triggersByKey.get(triggerKey)
                if( let Some(tw) <- twOpt ) {
                    let jobGroup = tw.jobKey.getGroup();
                    if(pausedJobGroups.contains(jobGroup)) {
                        continue;
                    }
                }
                resumeTrigger(triggerKey);
            }

            // Find all matching paused trigger groups, and then remove them.
            let op = matcher.getCompareWithOperator();
            let pausedGroups = ArrayList<String>();
            let matcherGroup = matcher.getCompareToValue();
            match (op) {
                case EQUALS =>
                    if(pausedTriggerGroups.contains(matcherGroup)) {
                        pausedGroups.append(matcher.getCompareToValue());
                    } 
                case _ =>
                    for (group in pausedTriggerGroups) {
                        if(op.evaluate(group, matcherGroup)) {
                            pausedGroups.append(group);
                        }
                    }
            }
            for (pausedGroup in pausedGroups) {
                pausedTriggerGroups.remove(pausedGroup);
            }

            return ArrayList(groups)
        }

    }