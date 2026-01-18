    func releaseIfScheduleChangedSignificantly( triggers: ArrayList<OperableTrigger>, triggerTime: Int64)  : Bool {
        if (isCandidateNewTimeEarlierWithinReason(triggerTime, true)) {
            // above call does a clearSignaledSchedulingChange()
            for (trigger in triggers) {
                qsRsrcs.getJobStore().releaseAcquiredTrigger(trigger);
            }
            triggers.clear();
            return true;
        }
        return false;
    }