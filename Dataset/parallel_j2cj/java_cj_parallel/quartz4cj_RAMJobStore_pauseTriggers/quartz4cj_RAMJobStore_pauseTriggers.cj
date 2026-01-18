    public func pauseTriggers( matcher: GroupMatcher<TriggerKey>) : Collection<String> {

        synchronized (lock) {
            let pausedGroups = ArrayList<String>();

            let op = matcher.getCompareWithOperator();
            match (op) {
                case EQUALS =>
                    if(pausedTriggerGroups.put(matcher.getCompareToValue())) {
                        pausedGroups.append(matcher.getCompareToValue());
                    } 
                case _  =>
                    for( group in  triggersByGroup.keys()) {
                        if(op.evaluate(group, matcher.getCompareToValue())) {
                            if(pausedTriggerGroups.put(matcher.getCompareToValue())) {
                                pausedGroups.append(group);
                            }
                        }
                    }
            }

            for (pausedGroup in pausedGroups) {
                let keys = getTriggerKeys(GroupMatcher<TriggerKey>.groupEquals(pausedGroup));
                for (key in keys) {
                    pauseTrigger(key);
                }
            }

            return pausedGroups;
        }

    }