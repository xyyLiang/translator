    public override func getFinalFireTime(): ?DateTime {
        if( !cronEx.isPresent() ) {
            return None 
        }

        var resultTime: ?DateTime = None
        if (getEndTime() != None) {
            resultTime = getTimeBefore( getEndTime().getOrThrow())
        } else {
            resultTime = cronEx.getOrThrow().getFinalFireTime()
        }
        
        if ((resultTime != None) && (resultTime.getOrThrow() < getStartTime())) {
            return None
        } 
        
        return resultTime
    }