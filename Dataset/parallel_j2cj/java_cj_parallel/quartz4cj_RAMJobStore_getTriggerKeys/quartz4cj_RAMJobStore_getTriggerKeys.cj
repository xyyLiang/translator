    public func getTriggerKeys( matcher: GroupMatcher<TriggerKey>) : Set<TriggerKey> {

        synchronized (lock) {

            let outList = HashSet<TriggerKey>();

            let op = matcher.getCompareWithOperator();
            let compareToValue = matcher.getCompareToValue();

            match(op) {
                case EQUALS =>
                    let grpMapOpt = triggersByGroup.get(compareToValue);
                    if ( let Some(grpMap) <- grpMapOpt ) {

                        for (tw in grpMap.values()) {
                            outList.put(tw.trigger.getKey());
                        }
                    } 

                case _ =>
                    for(  (group,map) in triggersByGroup )    {  
                        if(op.evaluate(group, compareToValue) && !map.isEmpty()) {
                            for (triggerWrapper in map.values()) {
                                outList.put(triggerWrapper.trigger.getKey());
                            }
                        }
                    }
            }

            return outList
        }
    }