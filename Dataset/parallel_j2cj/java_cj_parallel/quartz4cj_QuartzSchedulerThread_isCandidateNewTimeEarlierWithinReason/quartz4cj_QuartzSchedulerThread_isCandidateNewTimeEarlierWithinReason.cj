    func isCandidateNewTimeEarlierWithinReason(oldTime: Int64,  clearSignal: Bool) : Bool {
        synchronized(sigLock) {

            if (!isScheduleChanged()) {
                return false;
            }

            var earlier = false;

            if(getSignaledNextFireTime() == 0) {
                earlier = true;
            } else if(getSignaledNextFireTime() < oldTime ) {
                earlier = true;
            }

            if(earlier) {
                // so the new time is considered earlier, but is it enough earlier?
                let diff = oldTime - DateTime.currentTimeMillis();
                let threshold = if(qsRsrcs.getJobStore().supportsPersistence() ) {70} else {7}
                if(diff < threshold ) {
                    earlier = false;
                }
            }

            if(clearSignal) {
                clearSignaledSchedulingChange();
            }

            return earlier;
        }
    }