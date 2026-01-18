    public override func setEndTime(endTimeOpt: ?DateTime): Unit {

        if( let Some(endTime0) <- endTimeOpt ) {
            let endTime = endTime0.inTimeZone(getTimeZone())
            if ( endTime < getStartTime() ) {
                throw IllegalArgumentException("End time cannot be before start time")
            }
            this.endTime = endTime
        } else {
            this.endTime = None
        }
        
    } 