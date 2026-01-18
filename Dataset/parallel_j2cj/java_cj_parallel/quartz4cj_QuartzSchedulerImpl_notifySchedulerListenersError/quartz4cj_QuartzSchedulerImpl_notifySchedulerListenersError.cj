    public func notifySchedulerListenersError( msg: String,  se: SchedulerException)  : Unit {
        // build a list of all scheduler listeners that are to be notified...
        let schedListeners = buildSchedulerListenerList();

        // notify all scheduler listeners
        for(sl in schedListeners) {
            try {
                sl.schedulerError(msg, se);
            } catch (e:Exception) {
                log.error( "Error while notifying SchedulerListener of error: " ,e );
                log.error( "Original error (for notification) was: ${msg}" ,se );
            }
        }
    }