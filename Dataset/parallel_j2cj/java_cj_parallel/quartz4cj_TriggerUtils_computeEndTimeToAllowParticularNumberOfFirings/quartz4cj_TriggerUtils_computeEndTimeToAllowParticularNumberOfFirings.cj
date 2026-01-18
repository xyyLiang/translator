   public static func computeEndTimeToAllowParticularNumberOfFirings(trigg: OperableTrigger, cal: ?Calendar, numTimes: Int64): ?DateTime {

        let t = trigg.clone()
        if (!t.getNextFireTime().isPresent()) {
            t.computeFirstFireTime(cal)
        }
        
        var c = 0
        var endTimeOpt: ?DateTime = None
        
        for (_ in 0..numTimes ) {
            let dtOpt = t.getNextFireTime()
            if( let Some(dt) <- dtOpt ) {
                c++
                t.triggered(cal)
                if(c == numTimes) {
                    endTimeOpt = dt
                }
            } else {
                break
            }
        }
        
        match(endTimeOpt ) {
            case None => return None
            case Some(endTime) => return endTime.addSeconds(1)
        }
    }    
