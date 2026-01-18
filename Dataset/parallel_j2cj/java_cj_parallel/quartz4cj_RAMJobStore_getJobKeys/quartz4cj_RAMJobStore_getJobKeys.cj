    public func getJobKeys( matcher: GroupMatcher<JobKey>) : Set<JobKey> {
        
        synchronized (lock) {

            let outList = HashSet<JobKey>();

            let op = matcher.getCompareWithOperator();
            let compareToValue = matcher.getCompareToValue();

            match(op) {
                case EQUALS =>
                    let grpMapOpt = jobsByGroup.get(compareToValue);
                    if ( let Some(grpMap) <- grpMapOpt) {

                        for (jw in grpMap.values()) {
                            outList.put(jw.jobDetail.getKey());
                        }
                    } 

                case _ =>
                    for(  (group,map) in jobsByGroup )    {  
                        if(op.evaluate(group, compareToValue) && !map.isEmpty()) {
                            for ( jobWrapper  in  map.values()) {
                                outList.put(jobWrapper.jobDetail.getKey());
                            }
                        }
                    }
            }

            return outList
        }

    }