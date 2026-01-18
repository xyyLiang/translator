    public func compare(nextFireTime1Opt: ?DateTime, priority1: Int64, key1: TriggerKey, 
                        nextFireTime2Opt: ?DateTime, priority2: Int64, key2: TriggerKey): Ordering {

        if( nextFireTime1Opt != None || nextFireTime2Opt != None ) {     
     
            let nextFireTime1 = nextFireTime1Opt ?? return Ordering.GT
            let nextFireTime2 = nextFireTime2Opt ?? return Ordering.LT

            if(nextFireTime1 < nextFireTime2) {
                return Ordering.LT
            }

            if(nextFireTime1 > nextFireTime2) {
                return Ordering.GT
            }

            // priority 值越大越优先

            let comp: Int64 = priority2 - priority1
            if (comp != 0) {
                return if( comp < 0 ) { Ordering.LT } else {  Ordering.GT }
            }
        }

        return key1.compare(key2)
    }